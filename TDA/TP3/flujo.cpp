#include <iostream>
#include <map>
#include <vector>
#include <queue>
#include <algorithm>
#include <limits>

using namespace std;

int n,m;

int bfs(int s, int t, vector<int>& parent, vector<vector<int>> ady, vector<vector<int>>& cap) {
    fill(parent.begin(), parent.end(), -1);
    parent[s] = -2;
    queue<pair<int, int>> q;
    q.push({s, 300});

    while (!q.empty()) {
        int cur = q.front().first;
        int flow = q.front().second;
        q.pop();

        for (int next : ady[cur]) {
            if (parent[next] == -1 && cap[cur][next]) {
                parent[next] = cur;
                int new_flow = min(flow, cap[cur][next]);
                if (next == t)
                    return new_flow;
                q.push({next, new_flow});
            }
        }
    }

        return 0;
}

int maxflow(int s, int t, vector<vector<int>>& ady, vector<vector<int>>& cap) {
    vector<vector<int>> capb = cap;
    int flow = 0;
    vector<int> parent(2*n+2);
    int new_flow;

    while (new_flow = bfs(s, t, parent, ady, capb)) {
        flow += new_flow;
        int cur = t;
            while (cur != s) {
            int prev = parent[cur];
            capb[prev][cur] -= new_flow;
            capb[cur][prev] += new_flow;
            cur = prev;
        }
    }

    for (int i = 1; i < n+1;i++){
            for (int j = 1;j<n+1;j++){
                cap[i][j+n] -= capb[i][j+n];
            }
        }    

    return flow;
}



int main() {
    cin >> n >> m;

    vector<vector<int>> ady(2*n+2);
    vector<vector<int>> cap(2*n+2, vector<int>(2*n+2));
    
    int alumnos = 0;

    for (int i = 1; i < n+1;i++) {
        ady[0].push_back(i);
        cin >> cap[0][i];
        alumnos += cap[0][i];
        }

    
    for (int i = 1; i < n+1;i++) {
        ady[i].push_back(i+n);
        cap[i][i+n] = 100;
        ady[n+i].push_back(2*n+1);
        cin>>cap[n+i][2*n+1];
        }

    for (int i = 1; i < m+1;i++) {
        int a;
        int b;
        cin >> a >> b;
        ady[a].push_back(b+n);
        ady[b].push_back(a+n); 
        cap[a][b+n] = 100;
        cap[b][a+n] = 100;
    }
    
    int flujo = maxflow(0,2*n+1,ady,cap);
    
    if(flujo==alumnos){
        cout<<"YES ";
        for (int i = 1; i < n+1;i++){
            for (int j = 1;j<n+1;j++){
                cout << cap[i][j+n] << " ";
            }
        }
    } else {
        cout<<"NO";
    }
    
    return 0;
}