<script>
  import { onMount } from "svelte"
  import { AuthClient } from "@dfinity/auth-client"
  import dfinityLogo from "./assets/dfinity.svg"
  import { ConnectWallet } from "@proton/web-sdk";

  let dfinitySignedIn = false
  let client
  let principal = ""

  const initAuth = async () => {
    client = await AuthClient.create()
    const isAuthenticated = await client.isAuthenticated()

    if (isAuthenticated) {
      const identity = client.getIdentity()
      principal = identity.getPrincipal().toString()
      dfinitySignedIn = true
    }
  }

  const dfinitySignIn = async () => {
    const result = await new Promise((resolve, reject) => {
      client.login({
        identityProvider: "https://identity.ic0.app",
        onSuccess: () => {
          const identity = client.getIdentity()
          const principal = identity.getPrincipal().toString()
          resolve({ identity, principal })
        },
        onError: reject,
      })
    })
    principal = result.principal
    dfinitySignedIn = true
  }

  const dfinitySignOut = async () => {
    await client.logout()
    dfinitySignedIn = false
    principal = ""
  }

  onMount(initAuth)

  // Proton sign in
  // Proton sign in
  // Proton sign in

  // Constants
	const appIdentifier = "dfprototype";
	let link, session;

	async function createLink({ restoreSession }) {
		const result = await ConnectWallet({
			linkOptions: {
				endpoints: ["https://protontestnet.greymass.com"],
				restoreSession,
			},
			transportOptions: {
				requestAccount: "dfprototype", // Your proton account
				requestStatus: true,
			},
			selectorOptions: {
				appName: "dfprototype",
				appLogo:
					"https://freeos.io/freeos-appLogo.svg?v=3",
				customStyleOptions: {
					modalBackgroundColor: "#F4F7FA",
					logoBackgroundColor: "white",
					isLogoRound: true,
					optionBackgroundColor: "white",
					optionFontColor: "black",
					primaryFontColor: "black",
					secondaryFontColor: "#6B727F",
					linkColor: "#752EEB",
				},
			},
		});
		link = result.link;
		session = result.session;
	}

	async function protonSignIn() {
		// Create link
		await createLink({ restoreSession: false });
		console.log("User authorization:", session.auth); // { actor: 'fred', permission: 'active }
	}


</script>

<div class="auth-section">

  {#if !dfinitySignedIn && client}
    <button on:click={dfinitySignIn} class="auth-button">
      dfinity Sign In
      <img alt="" style="width: 33px; margin-right: -1em; margin-left: 0.7em;" src={dfinityLogo} />
    </button>
  {/if}

  {#if dfinitySignedIn}
    <p>dfinity id: {principal}</p>
    <button on:click={dfinitySignOut} class="auth-button">dfinity Sign out</button>
  {/if}

    <button on:click={protonSignIn} class="auth-button">
      Proton Sign In
    </button>
  
</div>

<style>
    .auth-section {
        padding: 1em;
        display: flex;
        justify-content: flex-end;
        align-items: center;
        text-align: right;
        position: fixed;
        top: 0;
        right: 0;
    }

    .auth-button {
        color: black;
        background: white;
        padding: 0 2em;
        border-radius: 60px;
        font-size: 1em;
        line-height: 40px;
        height: 33px;
        outline: 0;
        border: 0;
        cursor: pointer;
        text-decoration: underline;
        display: flex;
        align-items: center;
    }
</style>
