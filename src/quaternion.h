#ifndef QUATERNION_H
#define QUATERNION_H

// quaternions as:
// a + bi + cj + dk
typedef struct Quaternion
{
    double s;
    double v1;
    double v2;
    double v3;
} Quaternion;

// algebra
Quaternion qq_add(Quaternion q, Quaternion w);
Quaternion qq_sub(Quaternion q, Quaternion w);
Quaternion qq_prod(Quaternion q, Quaternion w);
Quaternion qd_prod(Quaternion q, double a);
Quaternion qq_div(Quaternion q, Quaternion w);
Quaternion qd_div(Quaternion q, double a);

double q_abs2(Quaternion q);
double q_abs(Quaternion q);
Quaternion q_conj(Quaternion q);
Quaternion q_inv(Quaternion q);

#endif