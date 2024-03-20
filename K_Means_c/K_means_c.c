#include <stdio.h>
#include <time.h>
#include <math.h>
#include <stdlib.h>
#define MAX_SIZE 1000 // Maximum array size


float k1x[MAX_SIZE], k1y[MAX_SIZE], k2x[MAX_SIZE], k2y[MAX_SIZE]; // Declare an array of MAX_SIZE
int k,  array_flag;
float distance_between, lowest_distance, largest_distance, largest_x,largest_y, lowest_x, lowest_y, mean1_x, mean2_x, mean1_y, mean2_y, mean1_x_new, mean2_x_new, mean1_y_new, mean2_y_new;
clock_t start, stop;


float arr_x[]={0.3637,0.4708,0.3526,0.4456,0.4460,0.4040,0.3543,0.3797,0.3400,0.4169,0.4086,0.5098,0.3418,0.4303,0.4329,0.3889,0.4738,0.4139,0.3928,0.3205,0.3927,0.4427,0.4709,0.4794,0.4694,0.4406,0.4304,0.3930,0.3591,0.3964,0.4120,0.4724,0.4855,0.5076,0.5813,0.5188,0.5490,0.5685,0.5138,0.4967,0.4264,0.6523,0.6098,0.4755,0.5387,0.4770,0.4152,0.5192,0.5282,0.5233,0.4729,0.5094,0.5135,0.5433,0.5891,0.5564,0.4806,0.5918,0.5420,0.5110,0.5213,0.5045,0.5652,0.5799,0.6116,0.4748,0.6447,0.6115,0.7565,0.7000,0.6254,0.5881,0.5498,0.6306,0.7126,0.6160,0.7338,0.6089,0.7331,0.5967,0.6570,0.7095,0.6019,0.6069,0.5738,0.6214,0.6405,0.6536,0.5573,0.7200,0.5227,0.6406,0.6328,0.5705,0.5892,0.6536,0.7605,0.6242,0.6374,0.6939};
float arr_y[]={0.4601,0.4964,0.4903,0.4139,0.4516,0.4533,0.4574,0.5264,0.4853,0.3894,0.4060,0.4337,0.4721,0.5538,0.5028,0.5985,0.5406,0.4715,0.4766,0.4598,0.4957,0.4973,0.4834,0.4469,0.5560,0.4792,0.5554,0.4528,0.4707,0.5456,0.5122,0.5369,0.6206,0.6273,0.5532,0.6704,0.6064,0.5257,0.6705,0.6245,0.6681,0.6057,0.6445,0.6278,0.6109,0.7321,0.6473,0.6157,0.5040,0.6504,0.5914,0.5784,0.5396,0.6314,0.6150,0.6489,0.5896,0.6287,0.6873,0.7533,0.6904,0.6984,0.7150,0.6201,0.6477,0.6099,0.5354,0.4269,0.5302,0.5494,0.4712,0.5815,0.4631,0.5195,0.4611,0.4477,0.5487,0.5473,0.5666,0.3948,0.5209,0.5020,0.5677,0.4848,0.5032,0.4901,0.4990,0.4627,0.4917,0.5755,0.4972,0.5766,0.4280,0.4784,0.4800,0.4635,0.4923,0.4693,0.4823,0.4389};

int N = 100;
int x=0;
int y=0;

void kmeans();
float find_mean(float array1[], int x);
int print_array(float k1[],float k2[], int x);
float square( float x);
int kmeans_dis(int x);
float distance(float x1,float x2,float y1, float y2);
float root( float x);


float find_mean(float array1[], int x){

	    float mx;
	    int i;
	    float sum1=0;
        for(i = 0; i < x; ++i)
            {
                sum1 +=array1[i];
            }

        mx = sum1/x;
        //printf("\n Mean function %d,", mx);

        return mx;
	}

int print_array(float k1[],float k2[], int x){

    int i;

    //kx=sizeof(k);
    //printf("Array size:", kx);
    printf("\n{");
    for(i=0; i<x; i++)
    {
        printf("(");
        printf("%.5f,", k1[i]);
        printf("%.5f", k2[i]);
        printf("),");
    }
    printf("}");
    return 0;

}

float square( float x){
    float sq;

    sq= x*x;

    //printf("\nSquare Function: Input: %d, Output: %d", x, sq );

    return sq;
    }

float root( float x){
    float sq;

    sq= x/(x*x);

    //printf("\nSquare Function: Input: %d, Output: %d", x, sq );

    return sq;
    }

int kmeans_dis(int x){

    float dis1, dis2;

    dis1 = distance(mean1_x, arr_x[x] , mean1_y, arr_y[x]);
    dis2 = distance(mean2_x, arr_x[x] , mean2_y, arr_y[x]);

    //printf("\ndis1: %f", dis1);
    //printf("\ndis2: %f", dis2);

    if(dis1>dis2){
        return 0;

    }
    else{

    return 1;
    }
}


float distance(float x1,float x2,float y1, float y2)
{
     float ax, bx;
     float dis;

     ax = x2-x1;
     bx = y2-y1;

     //dis =pow(square(ax)+square(bx), 0.5);
     dis =square(ax)+square(bx);

     return dis;
     }


     void kmeans(){

    int i,j;
    int it;
    //x=15, y=10;

   //while (mean1_x != mean1_x_new && mean2_x != mean2_x_new && mean1_y != mean1_y_new && mean2_y != mean2_y_new){
 for (it = 0; it < 100; it++){
        //printf("\niteration: (%d)", it+1);

            mean1_x = mean1_x_new;
            mean1_y = mean1_y_new;
            mean2_x = mean2_x_new;
            mean2_y = mean2_y_new;



        for (i = 0; i < N; i++){
            k1x[i]=0;
            k1y[i]=0;
        }

        for (i = 0; i < N; i++){
            k2x[i]=0;
            k2y[i]=0;
        }
        x=0, y=0;

        for (j = 0; j < N; j++)
            {
             array_flag= kmeans_dis(j);
             //printf("\nArray flag: %d\n", array_flag);

             if (array_flag==1){
               k1x[x]= arr_x[j];
               k1y[x]= arr_y[j];
               x=x+1;
             }
             else{
                k2x[y]= arr_x[j];
                k2y[y]= arr_y[j];
                y=y+1;
             }
            }

        mean1_x_new=find_mean(k1x, x);
        mean1_y_new=find_mean(k1y, x);
        mean2_x_new=find_mean(k2x, y);
        mean2_y_new=find_mean(k2y, y);

        //printf("\nNew 1st Mean: (%f,%f)", mean1_x_new,  mean1_y_new );
        //printf("\nNew 2nd Mean: (%f,%f)", mean2_x_new,  mean2_y_new );
        //printf("\nNew main 1st  Mean: (%f,%f)", mean1_x,  mean1_y );
        //printf("\nNew main 2nd Mean: (%f,%f)", mean2_x,  mean2_y );

        //printf("\n\nElements in 1st array are: ");
        //print_array(k1x,k1y, x );
        // print_array(k1y, x );
        //printf("\n1st array: %d ", x );
        //printf("\n2nd array: %d" , y );

       // printf("\nElements in 2nd array are: ");
        //print_array(k2x,k2y, y );

    }


}


int main()
{
    start = clock();
    int i, ite;
    printf("K-means 2d Started....");


    //printf("\nElements in (x,y) array are: ");
    //print_array(arr_x,arr_y,N);

    for (ite = 0; ite < 100; ite++){
        //printf("\nRuntime: (%d)", ite+1);

    lowest_x=arr_x[0];
    lowest_y=arr_y[0];

    largest_x=arr_x[0];
    largest_y=arr_y[0];



    lowest_distance= distance(0,lowest_x,0, largest_x);
    //printf(" ld: %d,", lowest_distance);

    largest_distance=lowest_distance;
    //printf(" lrd: %d,", largest_distance);

    for (i = 0; i < N; i++)
        {
            distance_between=distance(0,arr_x[i],0, arr_y[i]);

		if (largest_distance <distance_between ){
			largest_distance = distance_between;

			largest_x=arr_x[i];
            largest_y=arr_y[i];}


        if (lowest_distance> distance_between ){
			lowest_distance = distance_between;

			lowest_x=arr_x[i];
            lowest_y=arr_y[i];}
        }

    mean1_x= lowest_x-1;
    mean1_y= lowest_y-1;

    mean2_x= largest_x-1;
    mean2_y= largest_y-1;

    mean1_x_new=lowest_x;
    mean1_y_new=lowest_y;
    mean2_x_new=largest_x;
    mean2_y_new=largest_x;

    //printf("\n\nInitial First Mean: (%f,%f)", mean1_x_new, mean1_y_new );
    //printf("\nInitial Second Mean: (%f,%f)", mean2_x_new, mean2_y_new );

    kmeans();

    //printf("\n\nElements in 1st array are: ");
    //print_array(k1x,k1y, x );
   // print_array(k1y, x );

    //printf("\nElements in 2nd array are: ");
    //print_array(k2x,k2y, y );
   // print_array(k2y, y );

    }
	printf("\n\nElements in 1st array are: ");
    print_array(k1x,k1y, x );
   // print_array(k1y, x );

    printf("\nElements in 2nd array are: ");
    print_array(k2x,k2y, y );
   // print_array(k2y, y );

    stop = clock();
    double elapsed = (double)(stop - start) * 1000.0/ CLOCKS_PER_SEC;
    printf("\n\nTime elapsed in ms: %f\n", elapsed);

    return 0;

}

