#include <cstdio>

int main(int argc, char *argv[]) {
    FILE *fin = fopen(argv[3], "r");
    FILE *fout = fopen(argv[4], "w");

    fprintf(fout, "%%MatrixMarket matrix coordinate integer general\n");
    fprintf(fout, "%s %s %s\n", argv[1], argv[1], argv[2]);
    size_t i, j;
    while (fscanf(fin, "%zu %zu", &i, &j) > 0) {
        fprintf(fout, "%zu %zu\n", i + 1, j + 1);
    }

    fclose(fin);
    fclose(fout);
}