#include <math.h>
#include "quaternion.h"

Quaternion q_exp(Quaternion q)
{
    double e_s = exp(q.s);
    double v_norm = sqrt(q.v1 * q.v1 + q.v2*q.v2 + q.v3*q.v3);
    double v_scaler = sin(v_norm) / v_norm;

    Quaternion output = {
        e_s * cos(v_norm),
        e_s * q.v1 * v_scaler,
        e_s * q.v2 * v_scaler,
        e_s * q.v3 * v_scaler
    };
    return output;
}

Quaternion q_log(Quaternion q)
{
    double q_norm = q_abs(q);
    double v_norm = sqrt(q.v1 * q.v1 + q.v2*q.v2 + q.v3*q.v3);
    double v_scaler = acos(q.s / q_norm) / v_norm;

    Quaternion output = {
        log(q_norm),
        q.v1 * v_scaler,
        q.v2 * v_scaler,
        q.v3 * v_scaler
    };
    return output;
}

Quaternion qd_pow(Quaternion q, double p)
{
    return q_exp(qd_prod(q_log(q), p));
}