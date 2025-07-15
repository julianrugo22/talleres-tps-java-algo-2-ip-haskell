#include <iostream>
#include <vector>
#include <algorithm>

bool sortact(const std::pair<int,int>& a,const std::pair<int,int>& b) {
    return a.second < b.second;
}
 

int main() {    
    int tests;
    
    std::cin >> tests; 

    for (int t=0;t<tests;t++) {
        int act;
        std::cin >> act;
        std::vector<std::pair<int,int>> sched;

        for (int a=0;a<act;a++) {
            int c1;
            int c2;
            std::cin >> c1 >> c2;
            sched.push_back({c1,c2});
        }

        std::sort(sched.begin(),sched.end(),sortact);

        std::pair<int,int> ultimo = sched[0];
        int cont = 1;

        for (int i=1;i<act;i++){
            
            if (sched[i].first < ultimo.second){
                continue;
            } else {
                ultimo = sched[i];
                cont = cont + 1;
            }
        }
        std::cout << cont <<"\n";

    }      
}