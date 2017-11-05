/* CS315 Lab 3: C data types 
 * Author: Alexander Molodyh
 * Date: 11/5/2017
 * Class: CS360
 * Assignment: Lab3
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define MAX_FILE_SIZE (10485760)/*10 MB's*/
#define MB_BYTES (1048576)/*1 MB*/
#define SEQUENCE (255)/*start of mp3 header sequence*/
#define SEQUENCE_HALF (240)/*next 4 bits for start of mp3 header sequence*/
#define MPEG_SHIFT (3)/*right-shift amount for mpeg bit*/
#define LAYER_3_SHIFT (1)/*right-shift amount for layer 3 bit*/
#define BIT_RATE_SHIFT (4)/*right-shift amount for bitrate bit*/
#define FREQUENCY_SHIFT (2)/*right-shift amount for frequence bit*/

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

/*struct contains most of the data needed to work with*/
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

/*deletes the data in myfile struct*/
void deletemf(myfile);


int main( int argc, char ** argv )
{
	/*Open the file given on the command line*/
	if( argc != 2 )
	{
		printf( "Usage: %s filename.mp3\n", argv[0] );
		return(EXIT_FAILURE);
	}

	struct myfile mf; 
	mf.filename = argv[1];
	mf = initialize(mf);/*initialize file*/
	mf = readFile(mf);/*read in file*/
	
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

	mf = getSequenceIndex(mf);/*Index for start of SEQUENCE bits*/

	/*Check to see if the file format is in mpeg layer 3*/
	if(isBitOn(mf, MPEG_SHIFT, HEADER_SECTION_0) && isBitOn(mf, LAYER_3_SHIFT, HEADER_SECTION_0))
	{
		printf("File size: %.2f MB\n", ((mf.size/MB_BYTES) * 100) * 0.01f );
		printf("Is an mpeg layer 3: Yes\n");
		printf("Bitrate: %d\n", getBitrate(mf, BIT_RATE_SHIFT));
		printf("Frequency: %d Hz\n", getFrequency(mf, FREQUENCY_SHIFT));
		printf("Is copyright? %s\n", ((isBitOn(mf, COPYRIGHT_SHIFT, HEADER_SECTION_2)) ? "Yes" : "No"));
		printf("Is original? %s\n", ((isBitOn(mf, ORIGINAL_COPY_SHIFT, HEADER_SECTION_2) == 0 ) ? "Yes" : "No"));

		if(isBitOn(mf, COPYRIGHT_SHIFT, HEADER_SECTION_2))
		{
			if(isBitOn(mf, ORIGINAL_COPY_SHIFT, HEADER_SECTION_2))
			{
				printf("\nALERT!!! %s is not an ORIGINAL copy!!\n", mf.filename);
			}
		}
	}
	else/*file is not mpeg layer 3. delete struct and exit program*/
	{
		deletemf(mf);
		exit(EXIT_SUCCESS);
	}

	deletemf(mf);
}

/*retrieves the sampling rate frequency*/
int getFrequency(myfile mf, int shift)
{
	unsigned char c = mf.data[mf.currentIndex + HEADER_SECTION_1];
	c = 3 & (c >> shift);/*shift bit to the right 3 times then AND by 00000011 to get frequency output*/
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

	/*formula to calculate bitrate*/
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

/*sets the myfile parameters to calculate the bitrate*/
myfile setMfMath(myfile mf, int b, int i, int m)
{
	mf.base = b;
	mf.incrementor = i;
	mf.multiplier = m;
	return mf;
}

/*checks to see whether a bit is on or off*/
int isBitOn(myfile mf, int shift, int headerSection)
{
	if(mf.currentIndex == -1)
		return 0;

	unsigned char c = mf.data[mf.currentIndex + headerSection];
	return 1 & ( c >> shift );
}

/*finds the index where the mpeg header sequence starts. if it isn't found, then a -1 is returned*/
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

/*initializes the file*/
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

/*reads in the file by bytes*/
myfile readFile(myfile mf)
{
	/* How many bytes are there in the file?  If you know the OS you're
	 * on you can use a system API call to find out.  Here we use ANSI standard
	 * function calls.
	 */
	mf.size = 0;
	fseek( mf.fp, 0, SEEK_END );		/* go to 0 bytes from the end*/
	mf.size = ftell(mf.fp);				/* how far from the beginning?*/
	rewind(mf.fp);						/* go back to the beginning*/
	
	if( mf.size < 1 || mf.size > MAX_FILE_SIZE )
	{
		printf("File size is not within the allowed range\n"); 
		fclose(mf.fp);
		deletemf(mf);
		exit(EXIT_SUCCESS);
	}
	
	return mf;
}

/*deletes all pointers in myfile struct*/
void deletemf(myfile mf)
{
	delete(mf.filename);
	delete(mf.fp);
	delete(mf.data);
}