import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['stripePublishableKey', 'cardInput', 'cardTokenInput', 'cardError', 'submit']

  connect() {
    const form = this.element

    //
    // Fetch the stripe publishable key from the HTML element
    //
    const publishableKey = this.stripePublishableKeyTarget.dataset.stripePublishableKey

    const stripe = Stripe(publishableKey)
    const elements = stripe.elements()

    const clearCardError = () => this.cardErrorTarget.classList.add('d-none')

    //
    // Initialize the card number element
    //
    const cardElement = elements.create('card', {})
    cardElement.mount(this.cardInputTarget)
    cardElement.on('change', clearCardError)

    //
    // Add an on-submit listener for the form
    //
    form.addEventListener('submit', async e => {
      e.preventDefault()
      this.submitTarget.setAttribute('disabled', '')

      //
      // Attempt to tokenize the card number
      //
      const result = await stripe.createToken(cardElement)

      if (result.error) {
        //
        // On error, display the error message.
        //
        console.log('got error!', result.error)
        this.cardErrorTarget.classList.remove('d-none')
        this.cardErrorTarget.textContent = result.error.message
        this.submitTarget.removeAttribute('disabled')
      } else {
        //
        // On success, add the token to the hidden field and submit to the server
        //
        console.log('got token!', result.token)
        this.cardTokenInputTarget.value = result.token.id
        form.submit()
      }
    })
  }
}