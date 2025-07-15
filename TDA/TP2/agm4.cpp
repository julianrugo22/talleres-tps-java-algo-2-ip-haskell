#include <iostream>
#include <map>
#include <vector>
#include <algorithm>

using namespace std;

class DisjointSet {
    vector<int> rank, parent;
public:
    DisjointSet(int n) {
        rank.resize(n + 1, 0);
        parent.resize(n + 1);
        for (int i = 0; i <= n; i++) {
            parent[i] = i;
        }
    }

    int findSet(int nodo) {
        if (nodo == parent[nodo]) return nodo;
        return parent[nodo] = findSet(parent[nodo]);
    }

    void unionByRank(int u, int v) {
        int uRepresentative = findSet(u);
        int vRepresentative = findSet(v);
        if (uRepresentative == vRepresentative) return;

        if (rank[uRepresentative] < rank[vRepresentative]) {
            parent[uRepresentative] = vRepresentative;
        } else if (rank[uRepresentative] > rank[vRepresentative]) {
            parent[vRepresentative] = uRepresentative;
        } else {
            parent[vRepresentative] = uRepresentative;
            rank[uRepresentative]++;
        }
    }
};

struct Arista {
    int a, b, p;
    int id;
};

bool comp(Arista a, Arista b) {
    return a.p < b.p;
}

void dfs(int nodo, int id, vector<vector<pair<int, int>>> &Gprima, vector<bool> &vis, vector<int> &in, vector<int> &low, int &timer, vector<int> &res) {
    in[nodo] = low[nodo] = timer;
    timer++;
    vis[nodo] = true;
    
    for (pair<int, int> e : Gprima[nodo]) {
        if (e.second == id) continue;
        if (vis[e.first]) {
            low[nodo] = min(low[nodo], in[e.first]);
        } else {
            dfs(e.first, e.second, Gprima, vis, in, low, timer, res);
            low[nodo] = min(low[nodo], low[e.first]);
        }
    }
    if (id != 0) {
        if (in[nodo] == low[nodo]) res[id] = 2;
    }
}

void actualizarGprima(int a, int b, int id, vector<vector<pair<int, int>>> &Gprima, DisjointSet& dsu, vector<int> &res) {
    int acomp = dsu.findSet(a);
    int bcomp = dsu.findSet(b);
    if (acomp == bcomp) return;
    res[id] = 1;
    Gprima[acomp].push_back({bcomp, id});
    Gprima[bcomp].push_back({acomp, id});
}

void restaurarGprima(int a, int b, DisjointSet &dsu, vector<vector<pair<int, int>>> &Gprima, vector<bool> &vis) {
    int acomp = dsu.findSet(a);
    int bcomp = dsu.findSet(b);
    Gprima[acomp].clear();
    Gprima[bcomp].clear();
    vis[acomp] = vis[bcomp] = false;
    if (acomp != bcomp) dsu.unionByRank(acomp, bcomp);
}

int main() {
    long long n, m;
    cin >> n >> m;

    vector<Arista> E(m + 1); 
    
    vector<int> res(m + 1, 0);

    DisjointSet dsu(n);

    vector<int> in(n + 1), low(n + 1);
    vector<bool> vis(n + 1, false);
    int timer = 0;

    vector<vector<pair<int, int>>> Gprima(n + 1);

    for (int i = 1; i <= m; i++) {
        cin >> E[i].a >> E[i].b >> E[i].p;
        E[i].id = i;
    }

    sort(E.begin() + 1, E.end(), comp);
    
    for (int i = 1; i <= m;) {
        int j = i;

        for (; j <= m && E[i].p == E[j].p; j++) {
            actualizarGprima(E[j].a, E[j].b, E[j].id, Gprima, dsu, res);
        }
        
        timer = 0;
        for (int k = i; k < j; k++) {
            int x = dsu.findSet(E[k].a);
            if (!vis[x]) {
                dfs(x, 0, Gprima, vis, in, low, timer, res);
            }
        }

        for (int k = i; k < j; k++) {
            restaurarGprima(E[k].a, E[k].b, dsu, Gprima, vis);
        }
        i = j;
    }

    for (int i = 1; i <= m; i++) {
        if (res[i] == 0) cout << "none\n";
        else if (res[i] == 1) cout << "at least one\n";
        else cout << "any\n";
    }

    return 0;
}
