#include <cstdio>
#include <ctime>
#include <cstdlib>

int main(int argc, char *argv[]) {
    FILE *fin = fopen(argv[3], "r");
    FILE *fout = fopen(argv[4], "w");
    srand(time(nullptr));

    fprintf(fout, "%%MatrixMarket matrix coordinate integer general\n");
    fprintf(fout, "%s %s %s\n", argv[1], argv[1], argv[2]);
    size_t i, j;
    while (fscanf(fin, "%zu %zu", &i, &j) > 0) {
        fprintf(fout, "%zu %zu %d\n", i + 1, j + 1, rand() % 1024);
    }

    fclose(fin);
    fclose(fout);
}