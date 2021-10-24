#include <math.h>
#include "quaternion.h"

Quaternion q_zero()
{
    Quaternion output = {0,0,0,0};
    return output;
}

Quaternion qq_add(Quaternion q, Quaternion w)
{
    Quaternion output = {
        q.s + w.s,
        q.v1 + w.v1,
        q.v2 + w.v2,
        q.v3 + w.v3
    };

    return output;
}

Quaternion qq_sub(Quaternion q, Quaternion w)
{
    Quaternion output = {
        q.s - w.s,
        q.v1 - w.v1,
        q.v2 - w.v2,
        q.v3 - w.v3
    };

    return output;
}

Quaternion qq_prod(Quaternion q, Quaternion w)
{
    Quaternion output = {
        q.s * w.s  - q.v1 * w.v1 - q.v2 * w.v2 - q.v3 * w.v3,
        q.s * w.v1 + q.v1 * w.s  + q.v2 * w.v3 - q.v3 * w.v2,
        q.s * w.v2 - q.v1 * w.v3 + q.v2 * w.s  + q.v3 * w.v1,
        q.s * w.v3 + q.v1 * w.v2 - q.v2 * w.v1 + q.v3 * w.s
    };

    return output;
}

Quaternion qd_prod(Quaternion q, double a)
{
    Quaternion output = {
        q.s * a, q.v1 * a, q.v2 * a, q.v3 * a
    };

    return output;
}

double q_abs2(Quaternion q)
{
    return q.s * q.s + q.v1 * q.v1 + q.v2 * q.v2 + q.v3 * q.v3;
}

double q_abs(Quaternion q)
{
    return sqrt(q_abs2(q));
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
    double length2 = q_abs2(q);
    if (length2 == 0)
        return q_zero();
    else
        return qd_prod(q_conj(q), 1/length2);
}

Quaternion qq_div(Quaternion q, Quaternion w)
{
    return qq_prod(q, q_inv(w));
}

Quaternion qd_div(Quaternion q, double a)
{
    Quaternion output = {
        q.s / a, q.v1 / a, q.v2 / a, q.v3 / a
    };
    return output;
}