#include <iostream>
#include <map>
#include <vector>
#include <algorithm>

using namespace std;

void floydmod(vector<vector<long long>>& Lp, int n, vector<int> orden,  vector<long long> lres){
    long long res = 0;
    
    
    for (auto k:orden){
        for (auto i:orden){
            for (auto j:orden){
                if (Lp[i][j] > Lp[i][k] + Lp[k][j]){
                    Lp[i][j] = Lp[i][k] + Lp[k][j];
                }
            }
        }
    }

    for (auto i:orden) {
        for (auto j:orden) {
            res += Lp[i][j];
        }
    }

}

int main() {
    int n;
    cin >> n;
    vector<vector<long long>> L(n, vector<long long>(n));
    vector<int> orden(n);
    vector<long long> res;
    vector<bool> vis(n);
    
    res.push_back(0);

    if(n<2){
        cin >> n >> n;
        cout<<"0";
        return 0;
    }

    for (int i = 0; i < n;i++) {
        for (int j=0; j < n; j++) {
            cin >> L[i][j];
        }
    }

    for (int i = 0; i < n;i++) {
        int a;
        cin >> a;
        orden[i]= a-1;
    }

    if (n==1){
        cout<<"0";
        return 0;
    }
 

    floydmod(L,n,orden,res);

    for (int k = n-1; k >= 0;k--){
        cout<< res[k] << " ";
    }
    
    return 0;

}
