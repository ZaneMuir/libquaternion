#include <stdbool.h>
#include <math.h>
#include "quaternion.h"

bool q_isunit(Quaternion q, double atol)
{
    double norm = q_abs(q);
    if (fabs(norm - 1) <= atol)  // or approximate?
        return true;
    else
        return false;
}

Quaternion q_versor(Quaternion q)
{
    double norm = q_abs(q);
    return qd_div(q, norm);
}

Quaternion qq_rotate(Quaternion r, Quaternion q)
{
    Quaternion uq = q_versor(q);
    Quaternion output = qq_prod(qq_prod(q, r), q_conj(q));
    return output;
}

Quaternion qq_rotate_inv(Quaternion r, Quaternion q)
{
    Quaternion uq = q_versor(q);
    Quaternion output = qq_prod(qq_prod(q_conj(q), r), q);
    return output;
}