#pragma glslify: geocent_t = require('./t.glsl')
const float PI = 3.141592653589793;
vec3 geocent_inverse (geocent_t t, vec3 p) {
  float px = (p.x-t.x0)/t.k0;
  float py = (p.y-t.y0)/t.k0;
  float pz = (p.z-t.z0)/t.k0;
  float sqp = sqrt(px*px+py*py);
  float theta = atan(pz*t.a,sqp*t.b);
  float sintheta = sin(theta), costheta = cos(theta);
  float lat = atan(
    pz+t.eprime*t.eprime*t.b*sintheta*sintheta*sintheta,
    sqp-t.e*t.e*t.a*costheta*costheta*costheta
  );
  float lon = atan(py,px);
  float sinlat = sin(lat);
  float alt = (sqp/cos(lat))-t.a/sqrt(1.0-t.e*t.e*sinlat*sinlat);
  return vec3(lon*180.0/PI,lat*180.0/PI,alt);
}
#pragma glslify: export(geocent_inverse)
