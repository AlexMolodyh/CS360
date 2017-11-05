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
#define sequence (255)
#define sequence_half (240)



struct myfile{
	FILE *fp;
	int size;
	char *filename;
	unsigned char *data;
	int bytesRead;
	int currentIndex;
};

myfile initialize(myfile);
myfile readFile(myfile);
myfile getSequenceIndex(myfile);
int isBitOn(myfile, int);
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
	// Allocate memory on the heap for a copy of the file
	mf.data = (unsigned char *)malloc(mf.size);
	// Read it into our block of memory
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

	printf("The size of data is %d\n", sizeof(mf.data));
	printf("The size of size is %d\n", mf.size);

	mf = getSequenceIndex(mf);//Index for start of sequence bits
	int isMpeg = isBitOn(mf, 2);

	printf("Is MPEG? %d\n", isMpeg);
	printf("Index is %d\n", mf.currentIndex);

	int i;
	for(i = 0; i < 4000; i++)
	{
		printf("%d = " BYTE_TO_BINARY_PATTERN " \n", i, BYTE_TO_BINARY(mf.data[i]));
	}
		
	deletemf(mf);
}

int isBitOn(myfile mf, int shift)
{
	char c = mf.data[mf.currentIndex];
	return 1 & c>>shift;
}

myfile getSequenceIndex(myfile mf)
{
	int i; 
	for(i = 0; i < mf.size - 1; i++)
	{
		if((mf.data[i] ^ sequence) == 0 && (mf.data[i + 1] & sequence_half) == sequence_half)
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