
//Author: Christopher Hill For the EEE4120F course at UCT

#include<stdio.h>
#include<iostream>

using namespace std;



//creates a square matrix of dimensions Size X Size, with the values being the column number
void createKnownSquareMatrix(int Size, int* squareMatrix, bool displayMatrices){

	
	for(int i = 0; i<Size; i++){
		
		for(int j = 0; j<Size; j++){
			squareMatrix[i*Size+j] = j + 1;
			if(displayMatrices){
				cout<<squareMatrix[i*Size+j]<<"\t ";
			}
		}
		if(displayMatrices){
			cout<<"\n";
		}
	}
	

}


//creates a random square matrix of dimensions Size X Size, with values ranging from 1-100
void createRandomSquareMatrix(int Size, int* squareMatrix, bool displayMatrices){

	
	for(int i = 0; i<Size; i++){
		
		for(int j = 0; j<Size; j++){
			squareMatrix[i*Size+j] = rand() % 100 + 1;
			if(displayMatrices){
				cout<<squareMatrix[i*Size+j]<<"\t ";
			}
		}
		if(displayMatrices){
			cout<<"\n";
		}
	}
	

}




int main(void){

	//int N[10] = {3, 8, 12, 16, 24, 32, 48, 64, 88, 110};
	int N[3] = {3, 8, 12};
	for (int i = 0; i < 3; i++) {
		clock_t start, end; //Timers 

		//New code for prac 2.2
		bool displayMatrices = true;
		int Size = N[i];
		int countA = Size*Size;
		int matrixA[countA];
		createKnownSquareMatrix(Size,matrixA, false);
		if(displayMatrices){
			for(int i = 0; i<Size; i++){
				for(int j = 0; j<Size; j++){
						cout<<matrixA[i*Size+j]<<"\t ";
					
				}
				
				cout<<"\n";
				
			}
		}
		cout<<"Number of elements in matrix 1: "<<countA<<"\n";
		cout<<"Dimensions of matrix 1: "<<Size<<"x"<<Size<<"\n";
		cout<<"Matrix 1 pointer: "<<matrixA<<"\n";
		

		
		
		int countB = Size*Size;
		int matrixB[countB];
		createKnownSquareMatrix(Size, matrixB, false);
		for(int g = 0; g<countB; g++){
			matrixB[g] = 2*matrixB[g];
		}
		if(displayMatrices){
			for(int i = 0; i<Size; i++){
				for(int j = 0; j<Size; j++){
						cout<<matrixB[i*Size+j]<<"\t ";
					
				}
				
				cout<<"\n";
				
			}
		}
		cout<<"Number of elements in matrix 2: "<<countB<<"\n";
		cout<<"Dimensions of matrix 2: "<<Size<<"x"<<Size<<"\n";
		cout<<"Matrix 2 pointer: "<<matrixB<<"\n";
		
		
		start = clock(); //start running clock

		int outputAB[countA];

		for (int i = 0; i < Size; i++) {//multiplies AB
			for (int j = 0; j < Size; j++) {
				outputAB[i*Size + j] = 0;
				for (int k = 0; k < Size; k++) {
					outputAB[i*Size + j] += matrixA[i*Size + k] * matrixB[j + k*Size];
				}						
			}
		}

		int output[countA];

		for (int i = 0; i < Size; i++) {//mutiplies the above matrix by A again
			for (int j = 0; j < Size; j++) {
				output[i*Size + j] = 0;
				for (int k = 0; k < Size; k++) {
					output[i*Size + j] += outputAB[i*Size + k] * matrixA[j + k*Size];
				}						
			}
		}

		end = clock();//stop running clock
		printf("Size of matrices: %i * %i \n", Size, Size);
		printf ("Run Time: %0.8f sec \n",((float) end - start)/CLOCKS_PER_SEC);
		printf("--------------------------------------------------\n");
		
		//This if statement will display the matrix in output	
		if(displayMatrices){
			printf("\nOutput in the output_buffer \n");
			for(int j=0; j<countA; j++) {
				printf("%i \t " ,output[j]);
				if(j%Size == (Size-1)){
					printf("\n");
				}
			}
		}
	}
	return 0;
}
