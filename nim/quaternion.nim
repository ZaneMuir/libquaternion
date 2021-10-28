
## This module implements quaternion numbers
## and basic mathematical operations on them.
##
## Quaternion numbers are currently generic over f64 and f32.

# {.stack_trace: off, dynlib.}

import math
import strformat

type
  Quaternion*[T] = object
    ## A quaternion number, as a 4-component extended
    ## complex number system(s, (v1, v2, v3)).
    s*, v1*, v2*, v3*: T
  Quaternion32* = Quaternion[float32]
  ## Alias for a quaternion using 32-bit floats.
  Quaternion64* = Quaternion[float64]
  ## Alias for a quaternion using 64-bit floats.

func quaternion*[T: SomeFloat](s, v1, v2, v3: T = 0.0): Quaternion[T] =
  ## returns a `Quaternion[T]`
  result.s = s
  result.v1 = v1
  result.v2 = v2
  result.v3 = v3

func quaternion32*(s, v1, v2, v3: float32 = 0.0): Quaternion32 =
  ## returns a `Quaternion[float32]`
  result.s = s
  result.v1 = v1
  result.v2 = v2
  result.v3 = v3

func quaternion64*(s, v1, v2, v3: float64 = 0.0): Quaternion64 =
  ## returns a `Quaternion[float64]`
  result.s = s
  result.v1 = v1
  result.v2 = v2
  result.v3 = v3

func augmented*[T: SomeFloat](v1, v2, v3: T): Quaternion[T] =
  quaternion(T(0), v1, v2, v3)

func augmented*[T](q: Quaternion[T]): Quaternion[T] =
  result.s = 0
  result.v1 = q.v1
  result.v2 = q.v2
  result.v3 = q.v3

func augmented32*(v1, v2, v3: float32): Quaternion[float32] =
  quaternion32(float32(0), v1, v2, v3)

func augmented64*(v1, v2, v3: float64): Quaternion[float64] =
  quaternion64(float64(0), v1, v2, v3)


#[ TODO:
func `+=`
func `-=`
func `*=`
func `/=`
]#

func abs2*[T](q: Quaternion[T]): T =
  ## squared absolute value of `q`
  q.s * q.s + q.v1 * q.v1 + q.v2 * q.v2 + q.v3 * q.v3

func abs*[T](q: Quaternion[T]): T =
  ## absolute value of `q`
  sqrt(abs2(q))

func conjugate*[T](q: Quaternion[T]): Quaternion[T] =
  result.s = q.s
  result.v1 = - q.v1
  result.v2 = - q.v2
  result.v3 = - q.v3

func inv*[T](q: Quaternion[T]): Quaternion[T] =
  conjugate(q) / abs2(q)

func `==`*[T](q, w:Quaternion[T]): bool =
  q.s == w.s and q.v1 == w.v1 and q.v2 == w.v2 and q.v3 == w.v3

func `+`*[T](q, w:Quaternion[T]): Quaternion[T] =
  result.s = q.s + w.s
  result.v1 = q.v1 + w.v2
  result.v2 = q.v2 + w.v2
  result.v3 = q.v3 + w.v3

func `+`*[T](q: Quaternion[T], s: T): Quaternion[T] =
  result.s = q.s + s
  result.v1 = q.v1
  result.v2 = q.v2
  result.v3 = q.v3

func `+`*[T](s: T, q: Quaternion[T]): Quaternion[T] =
  result.s = q.s + s
  result.v1 = q.v1
  result.v2 = q.v2
  result.v3 = q.v3

func `-`*[T](q, w:Quaternion[T]): Quaternion[T] =
  result.s = q.s - w.s
  result.v1 = q.v1 - w.v2
  result.v2 = q.v2 - w.v2
  result.v3 = q.v3 - w.v3

func `-`*[T](q: Quaternion[T], s: T): Quaternion[T] =
  result.s = q.s - s
  result.v1 = q.v1
  result.v2 = q.v2
  result.v3 = q.v3

func `-`*[T](s: T, q: Quaternion[T]): Quaternion[T] =
  result.s = s - q.s
  result.v1 = - q.v1
  result.v2 = - q.v2
  result.v3 = - q.v3

func `*`*[T](q, w: Quaternion[T]): Quaternion[T] =
  result.s =   q.s * w.s - q.v1 * w.v1 - q.v2 * w.v2 - q.v3 * w.v3
  result.v1 = q.v1 * w.s +  q.s * w.v1 - q.v3 * w.v2 + q.v2 * w.v3
  result.v2 = q.v2 * w.s + q.v3 * w.v1 +  q.s * w.v2 - q.v1 * w.v3
  result.v3 = q.v3 * w.s - q.v2 * w.v1 + q.v1 * w.v2 +  q.s * w.v3

func `*`*[T](q: Quaternion[T], s: T): Quaternion[T] =
  result.s = q.s * s
  result.v1 = q.v1 * s
  result.v2 = q.v2 * s
  result.v3 = q.v3 * s

func `*`*[T](s: T, q:Quaternion[T]): Quaternion[T] =
  result.s = q.s * s
  result.v1 = q.v1 * s
  result.v2 = q.v2 * s
  result.v3 = q.v3 * s

func `/`*[T](q, w: Quaternion[T]): Quaternion[T] =
  q * inv(w)

func `/`*[T](q: Quaternion[T], s: T): Quaternion[T] =
  result.s = q.s / s
  result.v1 = q.v1 / s
  result.v2 = q.v2 / s
  result.v3 = q.v3 / s

func `/`*[T](s: T, q: Quaternion[T]): Quaternion[T] =
  s * inv(q)

func exp*[T](q: Quaternion[T]): Quaternion[T] =
  ## Quaternion exponential
  let scaler = exp(q.s)
  let vnorm = sqrt(q.v1 * q.v1 + q.v2 * q.v2 + q.v3 * q.v3)
  let vscaler = scaler * sin(vnorm) / vnorm

  result.s = scaler * cos(vnorm)
  result.v1 = vscaler * q.v1
  result.v2 = vscaler * q.v2
  result.v3 = vscaler * q.v3

func ln*[T](q: Quaternion[T]): Quaternion[T] =
  ## Quaternion lagarithm
  let vscaler = arccos(q.s / abs(q)) / sqrt(q.v1 * q.v1 + q.v2 * q.v2 + q.v3 * q.v3)
  
  result.s = ln(abs(q))
  result.v1 = vscaler * q.v1
  result.v2 = vscaler * q.v2
  result.v3 = vscaler * q.v3

func pow*[T](q: Quaternion[T], p: T): Quaternion[T] =
  ## Quaternion power with a scalar
  exp(ln(q) * p)

func pow*[T](q, p: Quaternion[T]): Quaternion[T] =
  ## Quaternion power
  exp(ln(q) * p)

func `$`*[T](q: Quaternion[T]): string =
  fmt"{q.s} + {q.v1}i + {q.v2}j + {q.v3}k"


# spatial rotations

func versor*[T](q: Quaternion[T]): Quaternion[T] =
  ## Unit quaternion, i.e. the length is 1/
  q / abs(q)

func angle*[T](q: Quaternion[T]): T =
  arccos(q.s / abs(q) / 2)

func axis*[T](q: Quaternion[T]): Quaternion[T] =
  let vnorm = sqrt(q.v1 * q.v1 + q.v2 * q.v2 + q.v3 * q.v3)
  augmented(q.v1 / vnorm, q.v2 / vnorm, q.v3 / vnorm)

func rotate*[T](q, w: Quaternion[T]): Quaternion[T] =
  ## rotation of vector `q` an angle `w.s` around unit vector `w.v`
  let u_w = versor(w)
  let r_prime = u_w * augmented(q) * conjugate(u_w)

  result.s = q.s
  result.v1 = r_prime.v1
  result.v2 = r_prime.v2
  result.v3 = r_prime.v3

func inv_rotate*[T](q, w: Quaternion[T]): Quaternion[T] =
  ## inverse rotation
  let u_w = versor(w)
  let r_prime = conjugate(u_w) * augmented(q) * u_w

  result.s = q.s
  result.v1 = r_prime.v1
  result.v2 = r_prime.v2
  result.v3 = r_prime.v3

func slerp*[T](q0, q1: Quaternion[T]; t: T): Quaternion[T] =
  ## quaternion interpolation with SLERP algorithm. t is in range 0..1
  pow(q1 * inv(q0), t) * q0