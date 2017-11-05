/* CS315 Lab 3: C data types */

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

#define BYTE_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c"
#define BYTE_TO_BINARY(byte)  \
  (byte & 0x80 ? '1' : '0'), \
  (byte & 0x40 ? '1' : '0'), \
  (byte & 0x20 ? '1' : '0'), \
  (byte & 0x10 ? '1' : '0'), \
  (byte & 0x08 ? '1' : '0'), \
  (byte & 0x04 ? '1' : '0'), \
  (byte & 0x02 ? '1' : '0'), \
  (byte & 0x01 ? '1' : '0') 

#define MAX_FILE_SIZE (10485760)//10 MB's
#define MB_BYTES (1048576)//1 MB
#define SEQUENCE (255)
#define SEQUENCE_HALF (240)
#define MPEG_SHIFT (3)
#define LAYER_3_SHIFT (1)
#define BIT_RATE_SHIFT (4)
#define FREQUENCY_SHIFT (2)

//used to access MP3 header sections(Bytes)
#define HEADER_SECTION_0 (0)
#define HEADER_SECTION_1 (1)
#define HEADER_SECTION_2 (2)

/*frequency identifiers*/
#define FREQUENCY_32 (2)
#define FREQUENCY_44 (0)
#define FREQUENCY_48 (1)

/*copyrighted shifts*/
#define COPYRIGHT_SHIFT (3)
#define ORIGINAL_COPY_SHIFT (2)


struct myfile{
	FILE *fp;
	double size;
	char *filename;
	unsigned char *data;
	int bytesRead;
	int currentIndex;

	int base;
	int incrementor;
	int multiplier;
};

myfile initialize(myfile);
myfile readFile(myfile);
myfile getSequenceIndex(myfile);
myfile getParams(myfile, unsigned char);
myfile setMfMath(myfile, int, int, int);

int isBitOn(myfile, int, int);
int getBitrate(myfile, int);
int getFrequency(myfile, int);

void deletemf(myfile);


int main( int argc, char ** argv )
{
	// Open the file given on the command line
	if( argc != 2 )
	{
		printf( "Usage: %s filename.mp3\n", argv[0] );
		return(EXIT_FAILURE);
	}

	struct myfile mf; 
	mf.filename = argv[1];

	mf = initialize(mf);
	mf = readFile(mf);
	
	printf( "File size: %.2f MB\n", ((mf.size/MB_BYTES) * 100) * 0.01f );
	
	/*Allocate memory on the heap for a copy of the file*/
	mf.data = (unsigned char *)malloc(mf.size);

	/*Read it into our block of memory*/
	mf.bytesRead = fread( mf.data, sizeof(unsigned char), mf.size, mf.fp );
	if( mf.bytesRead != mf.size )
	{
		printf( "Error reading file. Unexpected number of bytes read: %d\n",mf.bytesRead );
		fclose(mf.fp);
		deletemf(mf);
		exit(EXIT_SUCCESS);
	}
	
	// We now have a pointer to the first byte of data in a copy of the file, have fun
	// unsigned char * data    <--- this is the pointer

	mf = getSequenceIndex(mf);//Index for start of SEQUENCE bits
	if(isBitOn(mf, MPEG_SHIFT, HEADER_SECTION_0) && isBitOn(mf, LAYER_3_SHIFT, HEADER_SECTION_0))
	{
		printf("Is an mpeg layer 3\n");
		printf("The bitrate is: %d\n", getBitrate(mf, BIT_RATE_SHIFT));
		printf("The frequency is %d Hz\n", getFrequency(mf, FREQUENCY_SHIFT));
		printf("Is copyright? %s\n", ((isBitOn(mf, COPYRIGHT_SHIFT, HEADER_SECTION_2)) ? "True" : "False"));
		printf("Is original? %s\n", ((isBitOn(mf, ORIGINAL_COPY_SHIFT, HEADER_SECTION_2) == 0 ) ? "True" : "False"));
	}
	else
	{
		deletemf(mf);
		exit(EXIT_SUCCESS);
	}

	// printf("Index is %d\n", mf.currentIndex);

	// int i;
	// for(i = 0; i < 4000; i++)
	// {
	// 	printf("%d = " BYTE_TO_BINARY_PATTERN " \n", i, BYTE_TO_BINARY(mf.data[i]));
	// }
		
	deletemf(mf);
}

/*retrieves the sampling rate frequency*/
int getFrequency(myfile mf, int shift)
{
	unsigned char c = mf.data[mf.currentIndex + HEADER_SECTION_1];
	c = 3 & (c >> shift);
	int frequency = 0;

	if(c == FREQUENCY_32)
		frequency = 32000;
	else if(c == FREQUENCY_44)
		frequency = 44100;
	else if(c == FREQUENCY_48)
		frequency = 48000;
	
	return frequency;
}

/*retrieve the bitrate*/
int getBitrate(myfile mf, int shift)
{
	if(mf.currentIndex == -1)
		return 0;

	unsigned char c = mf.data[mf.currentIndex + HEADER_SECTION_1];
	c = c >> shift;
	mf = getParams(mf, c);
	int bitrate = mf.base + (mf.incrementor * mf.multiplier);
	return bitrate;
}

/*sets parameters to calculate bitrate*/
myfile getParams(myfile mf, unsigned char c)
{
	if( c <= 5)
		mf = setMfMath(mf, 32, 8, ((int) c) - 1);
	else if(c <= 9)
		mf = setMfMath(mf, 64, 16, ((int) c) - 5);
	else if(c <= 13)
		mf = setMfMath(mf, 128, 32, ((int) c) - 9);
	else
		mf = setMfMath(mf, 256, 64, ((int) c) - 13);
	return mf;
}

myfile setMfMath(myfile mf, int b, int i, int m)
{
	mf.base = b;
	mf.incrementor = i;
	mf.multiplier = m;
	return mf;
}

int isBitOn(myfile mf, int shift, int headerSection)
{
	if(mf.currentIndex == -1)
		return 0;

	unsigned char c = mf.data[mf.currentIndex + headerSection];
	return 1 & ( c >> shift );
}

myfile getSequenceIndex(myfile mf)
{
	int i; 
	for(i = 0; i < mf.size - 1; i++)
	{
		if((mf.data[i] ^ SEQUENCE) == 0 && (mf.data[i + 1] & SEQUENCE_HALF) == SEQUENCE_HALF)
		{
			mf.currentIndex = i + 1;
			return mf;
		}
	}
	mf.currentIndex = -1;
	return mf;
}

myfile initialize(myfile mf)
{
	
	mf.fp = fopen(mf.filename, "rb");
	if( mf.fp == NULL )
	{
		printf( "Can't open file %s\n", mf.filename );
		exit(EXIT_FAILURE);
	}

	return mf;
}

myfile readFile(myfile mf)
{
	// How many bytes are there in the file?  If you know the OS you're
	// on you can use a system API call to find out.  Here we use ANSI standard
	// function calls.
	mf.size = 0;
	fseek( mf.fp, 0, SEEK_END );		// go to 0 bytes from the end
	mf.size = ftell(mf.fp);				// how far from the beginning?
	rewind(mf.fp);						// go back to the beginning
	
	if( mf.size < 1 || mf.size > MAX_FILE_SIZE )
	{
		printf("File size is not within the allowed range\n"); 
		fclose(mf.fp);
		exit(EXIT_SUCCESS);
	}
	
	return mf;
}

void deletemf(myfile mf)
{
	delete(mf.filename);
	delete(mf.fp);
	delete(mf.data);
}