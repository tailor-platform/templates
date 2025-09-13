export default async () => {
  // Get access token for a Google OAuth connection
  const tokens = await tailor.authconnection.getConnectionToken('google-oauth');
  // Use the access token to call Google APIs
  const response = await fetch('https://www.googleapis.com/oauth2/v2/userinfo', {
    headers: {
      'Authorization': `Bearer ${tokens.access_token}`
    }
  });

  if (!response.ok) {
    throw new Error(`Failed to fetch user info: ${response.statusText}`);
  }
  const userInfo = await response.json();
  console.log(userInfo);
  return userInfo;
}