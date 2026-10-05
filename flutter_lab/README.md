# P03 — Laboratorio de Flutter

Aplicación resuelta para la práctica de introducción a Flutter. La app inicia
con una tarjeta de perfil y permite cambiar a una calculadora mediante la
navegación inferior.

## Datos de entrega

- **Curso:** Desarrollo de Software II
- **Docente:** Hans Harley Ccacyahuillca Bejar
- **Alumno:** Hector Paolo Barazorda Cuellar

## Ejecutar en Web

```bash
flutter pub get
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8081
```

Para mostrarla en un celular por USB Android:

```bash
adb reverse tcp:8081 tcp:8081
```

Luego abrir `http://127.0.0.1:8081` en el celular. También puede abrirse desde
la Mac usando `http://localhost:8081`.

## Verificación

```bash
flutter analyze
flutter test
```
