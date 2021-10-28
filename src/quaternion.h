#ifndef QUATERNION_H
#define QUATERNION_H

#include <stdbool.h>

// quaternions as:
// a + bi + cj + dk
typedef struct Quaternion
{
    double s;
    double v1;
    double v2;
    double v3;
} Quaternion;

// init
Quaternion q_zero();

// algebra
Quaternion qq_add(Quaternion q, Quaternion w);
Quaternion qd_add(Quaternion q, double a);
Quaternion dq_add(double a, Quaternion q);
Quaternion qq_sub(Quaternion q, Quaternion w);
Quaternion qd_sub(Quaternion q, double a);
Quaternion dq_sub(double a, Quaternion q);
Quaternion qq_prod(Quaternion q, Quaternion w);
Quaternion qd_prod(Quaternion q, double a);
Quaternion dq_prod(double a, Quaternion q);
Quaternion qq_div(Quaternion q, Quaternion w);
Quaternion qd_div(Quaternion q, double a);
Quaternion dq_div(double a, Quaternion q);

double q_abs2(Quaternion q);
double q_abs(Quaternion q);
Quaternion q_conj(Quaternion q);
Quaternion q_inv(Quaternion q);
double qq_dot(Quaternion q, Quaternion w);
Quaternion qq_cross(Quaternion q, Quaternion w);

// space
bool q_isunit(Quaternion q, double atol);
Quaternion q_versor(Quaternion q); // make a unit quanternion

Quaternion qq_rotate(Quaternion r, Quaternion q);
Quaternion qq_rotate_inv(Quaternion r, Quaternion q);

// special
Quaternion q_exp(Quaternion q);
Quaternion q_log(Quaternion q);
Quaternion qd_pow(Quaternion q, double p);
// Quaternion qq_pow(Quaternion q, Quaternion w);

#endif