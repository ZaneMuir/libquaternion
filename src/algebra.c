#include <math.h>
#include "quaternion.h"

Quaternion q_add(Quaternion q1, Quaternion q2)
{
    Quaternion output = {
        q1.s + q2.s,
        q1.v1 + q2.v1,
        q1.v2 + q2.v2,
        q1.v3 + q2.v3
    };

    return output;
}

Quaternion q_sub(Quaternion q1, Quaternion q2)
{
    Quaternion output = {
        q1.s - q2.s,
        q1.v1 - q2.v1,
        q1.v2 - q2.v2,
        q1.v3 - q2.v3
    };

    return output;
}

Quaternion q_prod(Quaternion q1, Quaternion q2)
{
    Quaternion output = {
        q1.s * q2.s  - q1.v1 * q2.v1 - q1.v2 * q2.v2 - q1.v3 * q2.v3,
        q1.s * q2.v1 + q1.v1 * q2.s  + q1.v2 * q2.v3 - q1.v3 * q1.v2,
        q1.s * q2.v2 - q1.v1 * q2.v3 + q1.v2 * q2.s  + q1.v3 * q1.v1,
        q1.s * q2.v3 + q1.v1 * q2.v2 - q1.v2 * q1.v1 + q1.v3 * q1.s
    };

    return output;
}

Quaternion q_prodd(Quaternion q, double a)
{
    Quaternion output = {
        q.s * a, q.v1 * a, q.v2 * a, q.v3 * a
    };

    return output;
}

double q_norm(Quaternion q)
{
    return sqrt(q.s * q.s + q.v1 * q.v1 + q.v2 * q.v2 + q.v3 * q.v3);
}

Quaternion q_conj(Quaternion q)
{
    Quaternion output = {
        q.s, -q.v1, -q.v2, -q.v3
    };
    return output;
}

Quaternion q_inv(Quaternion q)
{
    double length = q_norm(q);
    return q_prodd(q, 1/length);
}