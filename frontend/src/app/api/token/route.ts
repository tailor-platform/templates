import { NextResponse } from "next/server";

export async function POST() {
  const params = new URLSearchParams({
    grant_type: "client_credentials",
    client_id: process.env.NEXT_PUBLIC_TAILOR_PF_CLIENT_ID!,
    client_secret: process.env.NEXT_PUBLIC_TAILOR_PF_CLIENT_SECRET!,
  });

  try {
    const response = await fetch(
      `${process.env.NEXT_PUBLIC_TAILOR_PF_URL}/oauth2/token`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: params.toString(),
      },
    );

    if (!response.ok) {
      return NextResponse.json(
        { error: "Failed to fetch token" },
        { status: response.status },
      );
    }

    const data = await response.json();
    return NextResponse.json(data);
  } catch (error) {
    console.error("Error fetching token:", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 },
    );
  }
}
