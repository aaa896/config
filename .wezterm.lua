#include <stdio.h>
#include <stdlib.h>

typedef struct Matrix Matrix;
struct Matrix {
    int rows;
    int cols;
    int *data;
};

void mull_mat(Matrix *c, Matrix *a, Matrix *b) {
    c->rows = a->rows;
    c->cols = b->cols;

    for (int i = 0; i <a->rows; ++i) {
        for (int j = 0; j <b->cols; ++j) {
            for (int k = 0; k<a->cols; ++k) {
                c->data[(i * c->cols) + j] += a->data[ (i * a->cols) + k] * b->data[ (k * b->cols) + j];
            }
        }
    }
}

typedef struct Sub_View Sub_View ;
struct Sub_View {
    int idx;
    int square;
};

void rec_mat_mull(Matrix *c, Matrix *a, Matrix *b, Sub_View sv) {
    if (sv.square == 1) {
    }
    Sub_View a11;
}

void copy_data(Matrix *m, int *data) {
    if (m->data) free(m->data);
    m->data = malloc(m->rows * m->cols * sizeof(int));
    for (int row = 0; row <m->rows; ++row) {
        for (int col = 0; col <m->cols; ++col) {
            m->data[(row * m->cols) + col] = data[(row * m->cols) + col];
        }
    }
}


void print_mat(Matrix *mat) {
    for (int row = 0; row <mat->rows; ++row) {
        for (int col = 0 ; col <mat->cols ; ++col) {
            int c_index =  (row * mat->cols) + col;
            printf("%d ", mat->data[c_index]);
        }
        putchar('\n');
    }
}

int main() {
    Matrix a = {0};
    a.rows = 4;
    a.cols = 4;
    int a_data[] = {
        1, 2, 3, 1,
        2, 2, 1, 1,
        1, 3, 3, 1,
        1, 1, 3, 1,
    };
    copy_data(&a, a_data);

    Matrix b = {0};
    b.rows = 4;
    b.cols = 4;
    int b_data[] = {
        1, 3, 3, 1,
        1, 2, 3, 1,
        1, 1, 1, 1,
        1, 2, 1, 1,
    };

    copy_data(&b, b_data);

    Matrix c = {0};
    c.rows = 4;
    c.cols = 4;
    {
        int c_data[] = {
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0,
        };
        copy_data(&c, c_data);
    }
    mull_mat(&c, &a, &b);
    print_mat(&c);
    putchar('\n');

    {
        int c_data[] = {

            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0,
        };
        copy_data(&c, c_data);
    }
    rec_mat_mull(&c,&a,&b, 0, 4);

    print_mat(&c);
}
