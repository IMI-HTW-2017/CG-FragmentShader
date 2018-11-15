#version 330

#define PI 3.1415926535897932384626433832795

out vec3 pixelColor;

vec2 coord = gl_FragCoord.xy;

float degToRad(float degree) {
    return PI / 180 * degree;
}

vec2 rotate(vec2 vector, float angle) {
    angle = degToRad(angle);
    float sin = sin(angle);
    float cos = cos(angle);

    mat2 rotationMatrix = mat2(cos, -sin, sin, cos);

    return vector * rotationMatrix;
}

void drawRect(vec2 position, vec2 size, float angle) {
    coord = rotate(coord - (position + size / 2.0), -angle);
    coord = coord + position + size / 2.0;

    if (coord.x >= position.x && coord.x <= position.x + size.x &&
        coord.y >= position.y && coord.y <= position.y + size.y) {
        pixelColor = vec3(1.0, 0.0, 0.0);
    }

    coord = rotate(coord - (position + size / 2.0), angle);
    coord = coord + position + size / 2.0;
}

void drawCircle(vec2 position, float radius) {
    float distance = distance(position, coord);
    if (distance <= radius) {
        pixelColor = vec3(1.0, 0.0, 0.0);
    }
}

void drawLine(vec2 firstPoint, vec2 secondPoint, float weight) {
        vec2 direction = secondPoint - firstPoint;
        vec2 perpendicular = vec2(direction.y, -direction.x);
        vec2 directionToPoint = firstPoint - coord;
        float distance = abs(dot(normalize(perpendicular), directionToPoint));

        if (distance <= weight) {
            pixelColor = vec3(1.0, 0.0, 0.0);
        }
}

void main() {
    pixelColor = vec3(0.258, 0.956, 0.749);

    drawRect(vec2(500.0, 200.0), vec2(100.0, 30.0), 45.0);
    drawCircle(vec2(1000.0, 300.0), 50.0);


    drawRect(vec2(600.0, 400.0), vec2(50.0, 250.0), 90.0);
    drawCircle(vec2(625.0, 650.0), 100.0);

    drawRect(vec2(100.0, 100.0), vec2(50.0, 50.0), 0.0);

    drawLine(vec2(50.0, 50.0), vec2(500.0, 200.0), 0.1);
}