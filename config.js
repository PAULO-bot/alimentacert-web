// AlimentaCert PRO — CONFIGURACIÓN
// 1) Crea en Stripe un Payment Link de SUSCRIPCIÓN mensual por 12,90 €.
// 2) Pega el enlace aquí.
// 3) Para bloqueo real por impago/cancelación, configura subscriptionStatusEndpoint
//    con un endpoint seguro que devuelva JSON: {"status":"active|past_due|unpaid|canceled|expired"}.
window.ALIMENTACERT_CONFIG = {
  stripePaymentLink: "",
  subscriptionStatusEndpoint: ""
};
