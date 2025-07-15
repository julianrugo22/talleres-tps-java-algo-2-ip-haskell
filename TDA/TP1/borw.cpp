#include <iostream>
#include <vector>

int borw(int p , int b, int w, int arr[], int n, std::vector<std::vector<std::vector<int>>>& memo){
        
        if (p>=n){
            return 0;
        } else if (memo[p][b][w] != -1){
            return memo[p][b][w];
        } else if ((b == n) && (w == n)){
            memo[p][b][w] = std::min((std::min(borw(p+1,p,w,arr,n,memo),borw(p+1,b,p,arr,n,memo))),1 + borw(p+1,b,w,arr,n,memo));
            return memo[p][b][w];
        } else if ((b == n)){
            if (arr[p]<arr[w]){
                memo[p][b][w] = std::min((std::min(borw(p+1,p,w,arr,n,memo),borw(p+1,b,p,arr,n,memo))),1 + borw(p+1,b,w,arr,n,memo));  
            } else{
                memo[p][b][w] = (std::min(borw(p+1,p,w,arr,n,memo),1 + borw(p+1,b,w,arr,n,memo)));
            }
            return memo[p][b][w];
        } else if ((w == n)){
            if (arr[p]>arr[b]){
                memo[p][b][w] = std::min((std::min(borw(p+1,p,w,arr,n,memo),borw(p+1,b,p,arr,n,memo))),1 + borw(p+1,b,w,arr,n,memo));                
            } else{
                memo[p][b][w] = (std::min(borw(p+1,b,p,arr,n,memo),1 + borw(p+1,b,w,arr,n,memo)));
            }
            return memo[p][b][w];
        } else {
            if ((arr[p] > arr[b]) && (arr[p] < arr[w])){ 
                memo[p][b][w] = std::min((std::min(borw(p+1,p,w,arr,n,memo),borw(p+1,b,p,arr,n,memo))),1 + borw(p+1,b,w,arr,n,memo));
                return (memo[p][b][w]);
            } else if (arr[p]<=arr[b] && arr[p]>=arr[w]){
                memo[p][b][w] = borw(p+1,b,w,arr,n,memo) + 1;
                return (memo[p][b][w]);
            } else if (arr[p]>arr[b] && arr[p]>=arr[w]){
                memo[p][b][w] = std::min(borw(p+1,p,w,arr,n,memo),borw(p+1,b,w,arr,n,memo) + 1);
                return (memo[p][b][w]);
            } else if (arr[p]<=arr[b] && arr[p]<arr[w]){
                memo[p][b][w] = std::min(borw(p+1,b,p,arr,n,memo),borw(p+1,b,w,arr,n,memo) + 1);
                return (memo[p][b][w]);
            } else {
                std::cout <<"ERROR\n";
                return -10000000;
            }
        }  
    }

int main() {
    int N = 0;
    
    while (N != -1){
        std::cin >> N; 

        if (N == -1){
            continue;
        }        

        std::vector<std::vector<std::vector<int>>> memo(N, std::vector<std::vector<int>>(N+1, std::vector<int>(N+1,-1)));
        
        int test_case[N];

        for(int i=0;i<N;i++){
            std::cin >> test_case[i];
        }

        std::cout << borw(0, N, N, test_case, N, memo)<<"\n";
    }
    
    return 0;
}



    
