#include<iostream>
#include <vector>
#include <algorithm>

int entranvacas(std::vector<int> barns,int cows,int mindist){
    int cont = 1;
    int ult = barns[0];

    for (int i=1;i<barns.size();i++){
        if (barns[i] - ult >= mindist){
            cont += 1;
            ult = barns[i];
            if (cont == cows){
                return true;
            }
                
        }                     
    }
    return false;
}


int main() {
    int tests;  
    std::cin >> tests; 
    
    for (int t=0;t<tests;t++) {
        int mld;
        int stalls;
        int cows;
        std::cin >> stalls; 
        std::vector<int> barns;
        std::cin >> cows; 
        for (int i=0;i<stalls;i++){
            int b;
            std::cin >> b;
            barns.push_back(b);
        }
        std::sort(barns.begin(),barns.end());

        int max = barns[stalls - 1] - barns[0];
        int min = 1;

        while (max >= min){
            int med = (max + min)/2;

            if (entranvacas(barns,cows,med)){
                mld = med;
                min = med + 1; 
            } else {
                max = med - 1;
            }
        }        

        std::cout << mld <<"\n";

    }      


}