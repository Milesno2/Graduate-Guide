const allowedOrigins = ['*'];

function corsHeaders(origin) {
  const allowOrigin = allowedOrigins.includes('*') || allowedOrigins.includes(origin) ? '*' : '';
  return {
    'Access-Control-Allow-Origin': allowOrigin,
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type, Authorization'
  };
}

exports.handler = async function handler(event) {
  const origin = event.headers?.origin || event.headers?.Origin || '';
  if (event.httpMethod === 'OPTIONS') {
    return { statusCode: 204, headers: corsHeaders(origin), body: '' };
  }

  if (event.httpMethod !== 'POST') {
    return {
      statusCode: 405,
      headers: corsHeaders(origin),
      body: JSON.stringify({ error: 'Method Not Allowed' })
    };
  }

  try {
    const body = event.body ? JSON.parse(event.body) : {};
    const { name, email, message } = body;

    if (!name || !email || !message) {
      return {
        statusCode: 400,
        headers: corsHeaders(origin),
        body: JSON.stringify({ error: 'Missing required fields: name, email, message' })
      };
    }

    // Placeholder: implement your handling here (e.g., send email, store in DB)
    // For demo purposes we just echo back a success response
    return {
      statusCode: 200,
      headers: { ...corsHeaders(origin), 'Content-Type': 'application/json' },
      body: JSON.stringify({ ok: true, received: { name, email, message } })
    };
  } catch (error) {
    return {
      statusCode: 500,
      headers: corsHeaders(origin),
      body: JSON.stringify({ error: 'Internal Server Error' })
    };
  }
}

