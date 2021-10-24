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

Quaternion q_add(Quaternion q1, Quaternion q2);
Quaternion q_sub(Quaternion q1, Quaternion q2);
Quaternion q_prod(Quaternion q1, Quaternion q2);
Quaternion q_prodd(Quaternion q, double a);

double q_norm(Quaternion q);
Quaternion q_conj(Quaternion q);
Quaternion q_inv(Quaternion q);

#endif