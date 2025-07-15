#include <iostream>
#include <vector>
#include <tuple>

bool temp(int i, int j, int sum, std::vector<std::vector<int>>& matriz, std::vector<std::vector<std::tuple<int, int>>>& memo, int n, int m){
    bool res;

    if ((m+n-1)%2 != 0) return false;
    if (i >= n || j >= m) return false;
    
    int min = std::get<0>(memo[i][j]);
    int max = std::get<1>(memo[i][j]);

    sum += matriz[i][j];

    if (min == INT_MAX && max == INT_MIN) {
        memo[i][j] = {sum, sum};
    } else {
        if (sum >= min && sum <= max) return false; 
        memo[i][j] = {std::min(min, sum), std::max(max, sum)};
    }

    if (i == n-1 && j == m-1) {
        return (sum == 0);
    }

    return temp(i+1, j, sum, matriz, memo, n, m) || temp(i, j+1, sum, matriz, memo, n, m);

    return res;
}

int main() {    
    int tests;
    
    std::cin >> tests; 

    for (int t=0;t<tests;t++) {
        int n, m;
        std::cin >> n >> m;
        
        std::vector<std::vector<int>> matriz(n, std::vector<int>(m));
        std::vector<std::vector<std::tuple<int, int>>> memo(n, std::vector<std::tuple<int, int>>(m, {INT_MAX, INT_MIN}));
        
        for (int i=0;i<n;i++){
            for (int j=0;j<m;j++) {
                std::cin >> matriz[i][j];
            }
        }
    if(temp(0,0,0,matriz,memo,n,m)){
        std::cout << "YES\n";
    } else {std::cout << "NO\n"; }
    }      
}