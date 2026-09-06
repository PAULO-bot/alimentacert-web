ALIMENTACERT · PAQUETE 8 PUNTOS · 2026-09

QUÉ INCLUYE
1) Curso multidioma ES/EN/RU/AR: 8 módulos.
2) Examen multidioma: 20 preguntas aleatorias de banco de 24; aprobado 80%; reintentos.
3) Formulario post-aprobado: nombre, documento, email, país.
4) Esquema Supabase con RLS y tablas de intentos, pagos y certificados.
5) Stripe Checkout 9,90 EUR mediante Edge Function.
6) Webhook firmado de Stripe: ÚNICA fuente de verdad para emitir certificado. Idempotencia por session/payment.
7) Certificado con código único y verificación pública sin documento completo.
8) Flujo de prueba de punta a punta y checklist de despliegue.

IMPORTANTE
- El frontend está listo para GitHub Pages.
- Para cobrar de verdad hacen falta las claves privadas de Stripe en secretos de Supabase; NO van en GitHub.
- config.js solo admite clave PUBLICABLE si se usa. Nunca service_role ni Stripe secret.
- El webhook verifica la firma Stripe y solo crea certificado si payment_status=paid.
- La página pago-ok NO emite certificados.
- La versión incluida genera código y registro verificable. La generación de un PDF binario y envío por email se deja como siguiente capa server-side para no fingir una integración de correo/Storage que todavía no tiene credenciales.

LEGAL ESPAÑA
La web debe presentarse como formación privada en higiene alimentaria. Tras la derogación del RD 202/2000, AESAN indica que las entidades formadoras no necesitan homologación/autorización administrativa para prestar esta formación, y no deben afirmar que están homologadas/autorizadas por AESAN o el Ministerio. La empresa alimentaria debe garantizar formación adecuada a la actividad conforme al Reglamento (CE) 852/2004.

DESPLIEGUE
A. GitHub Pages: subir index.html, config.js, pago-ok.html y 4 JPG.
B. Supabase SQL Editor: ejecutar supabase/schema.sql.
C. Supabase Edge Functions: desplegar create-checkout, stripe-webhook, certificate.
D. Secrets Supabase: STRIPE_SECRET_KEY, STRIPE_WEBHOOK_SECRET, SITE_URL, SITE_ORIGIN, SUPABASE_SERVICE_ROLE_KEY.
E. Stripe: webhook -> /functions/v1/stripe-webhook; evento checkout.session.completed.
F. config.js: poner checkoutEndpoint y verifyEndpoint.
G. Probar Stripe TEST antes de Live.
