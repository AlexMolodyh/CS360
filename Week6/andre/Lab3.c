/* CS360 Lab 3: C data types */

#include <stdio.h>
#include <stdlib.h>

#define MAXIMUM_MP3 (10485760)
#define MINIMUM_MP3 (1)
#define MEGABYTE (1048576)

unsigned char* readFile(FILE*,double);

double getSize(FILE*);

int findBitRate(unsigned char*, int);

int findFrequency(unsigned char*, int);

int isFileOriginal(unsigned char*, int);

int isFileCopyrighted(unsigned char*, int);

FILE* initialize(FILE*, char*);

int isFileMPEGLayer3(unsigned char*, int);

int findSequenceHeader(unsigned char * data, int size);


FILE *fp = NULL;


int main( int argc, char ** argv )
{
	// Open the file given on the command line
	if( argc != 2 )
	{
		printf( "Usage: %s filename.mp3\n", argv[0] );
		return(EXIT_FAILURE);
	}
	// Clean up
	fp = initialize(fp, argv[1]);
	double sizeMP3 = getSize(fp);
	unsigned char *mp3Data = readFile(fp, sizeMP3);
	int sequenceIndex = findSequenceHeader(mp3Data, sizeMP3);

	printf("Sequence header is: %d %d\n", sequenceIndex, mp3Data[sequenceIndex - 1]);

	//Print statement
	if(isFileMPEGLayer3(mp3Data, sequenceIndex) == 1)
	{
		printf("MP3 is a Layer III\n");
		findBitRate(mp3Data, sequenceIndex);
		findFrequency(mp3Data, sequenceIndex);
		isFileCopyrighted(mp3Data, sequenceIndex);
		isFileOriginal(mp3Data, sequenceIndex);
	}
	else
	{
		printf("MP3 is not Layer III, exiting.\n");
	}
	
	fclose(fp);				// close and free the file
	return(EXIT_SUCCESS);		// or return 0;
}

FILE* initialize (FILE *fp, char *fileName)
{
	
	fp = fopen(fileName, "rb");
	if( fp == NULL )
	{
		printf( "Can't open file %s\n", fileName );
		exit(EXIT_FAILURE);
	}
	return fp;
}

double getSize(FILE *fp)
{
	double size = 0;
	fseek( fp, 0, SEEK_END );		// go to 0 bytes from the end
	size = ftell(fp);				// how far from the beginning?
	rewind(fp);
	return size;		
}
	
	// How many bytes are there in the file?  If you know the OS you're
	// on you can use a system API call to find out.  Here we use ANSI standard
	// function calls.
unsigned char* readFile (FILE *fp, double size)
{

	if( size < MINIMUM_MP3 || size > MAXIMUM_MP3 )
	{
		printf("File size is not within the allowed range\n"); 
		return 0;
	}

	double sizeFile = size/MEGABYTE;
	
		printf( "File size: %.2f MB\n", sizeFile );


	// Allocate memory on the heap for a copy of the file
	unsigned char * data = (unsigned char *)malloc(size);
	// Read it into our block of memory
	size_t bytesRead = fread( data, sizeof(unsigned char), size, fp );
	if( bytesRead != size )
	{
		printf( "Error reading file. Unexpected number of bytes read: %zu\n",bytesRead );
		//Memory Leak ?
		free(data);
		exit (EXIT_SUCCESS);
	}

	// We now have a pointer to the first byte of data in a copy of the file, have fun
	// unsigned char * data    <--- this is the pointer
	
 return data;
 }
/* Find header sequence */
 int findSequenceHeader(unsigned char *data, int size)
 {
 	int i;
 	for(i = 0; i < size -1; i++)
 	{
		 if( (data[i] ^ 255) == 0 && (data[i+1] & 240) == 240)
		 {
			 return i+1;
		 }
	 }
	 return -1;
 }

/* Find bit rate of MP3 */ 
int findBitRate(unsigned char *mp3Data, int index)
{
	int bitRate = 0;
	if ((mp3Data[index+1] & 255) == 160)
	{
		bitRate = 10;
	}
	if ((mp3Data[index+1] & 255) == 144)
	{
		bitRate = 9;
	}
	if ((mp3Data[index+1] & 255) == 128)
	{
		bitRate = 8;
	}
	if ((mp3Data[index+1] & 255) == 112)
	{
		bitRate = 7;
	}
	if ((mp3Data[index+1] & 255) == 96)
	{
		bitRate = 6;
	}
	if ((mp3Data[index+1] & 255) == 80)
	{
		bitRate = 5;
	}
	if ((mp3Data[index+1] & 255) == 64)
	{
		bitRate = 4;
	}
	if ((mp3Data[index+1] & 255) == 48)
	{
		bitRate = 3;
	}
	if ((mp3Data[index+1] & 255) == 32)
	{
		bitRate = 2;
	}
	if ((mp3Data[index+1] & 255) == 16)
	{
		bitRate = 1;
	}
	
	if (bitRate >= 0 && bitRate <= 255)
	{
		switch (bitRate)
		{
			case 10 :
				bitRate = 160;
				break;
			case 9 :
				bitRate = 144;
				break;
			case 8 :
				bitRate = 128;
				break;
			case 7 :
				bitRate = 112;
				break;
			case 6 :
				bitRate = 96;
				break;
			case 5 :
				bitRate = 80;
				break;
			case 4 :
				bitRate = 64;
				break;
			case 3 :
				bitRate = 56;
				break;
			case 2 :
				bitRate = 48;
				break;
			case 1 :
				bitRate = 40;
				break;
			case 0 :
				bitRate = 32;
				break;			
			default :
				bitRate = 0;
		}
		printf("Bit Rate is %i kbps\n", bitRate);
	}
	else
	{
		printf("Bit Rate is unknown\n");
	}
	return 0;
}


 /* Find frequency in human terms. Convert from Hz to kHz */
int findFrequency(unsigned char *mp3Data, int index)
{
	int frequency = 0;
	if((mp3Data[index+1] & 12) == 0) //44100
	{
		frequency = 0;
	}
	if((mp3Data[index+1] & 12) == 4) //48000
	{
		frequency = 1;
	}
	if((mp3Data[index+1] & 12) == 8) //32000
	{
		frequency = 2;
	}
	
	if (frequency >= 0 && frequency <= 12)
	switch (frequency)
	{
		case 0:
			frequency = 44100;
			break;
		case 1:
			frequency = 48000;
			break;
		case 2 :
			frequency = 32000;
			break;
		case 3 :
			frequency = 0;
			break;
	}
	printf("Frequency is %d.%.2d Hz\n", frequency/1000, frequency % 1000);
	return 0;
}

/* Is file an MP3 */
int isFileMPEGLayer3(unsigned char *mp3Data, int index)
{
	if((mp3Data[index] & 6) == 2)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

/* Is file copyrighted. */
int isFileCopyrighted(unsigned char *mp3Data, int index)
{
	if((mp3Data[index+2] & 8) == 8)
	{
		printf("The song is copyrighted\n");
	}
	else
	{
	   
	   printf("The song is not copyrighted\n");
	}
	return 0;
}
/* Is file the original. */ 
int isFileOriginal(unsigned char *mp3Data, int index)
{
	if((mp3Data[index+2] & 4) == 4)
	{
		printf("The song is on original media\n");
	}
	else
	{
		printf("The song is a copy of original media\n");
	}
		return 0;	
}




