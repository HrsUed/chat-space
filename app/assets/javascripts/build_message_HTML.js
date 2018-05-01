function buildMessageHTML(message) {
  const content_html = message.content == "" ? `` : `<div class="message-body__content">${message.content}</div>`
  const image_html = message.image == null ? `` : `<div class="message-body__image"><img src="${message.image}"></div>`

  const html =
`
<div class="message" data-message-id="${message.id}">
  <div class="message-header">
    <div class="message-header__user-name">
      ${message.user_name}
    </div>
    <div class="message-header__posted-date">
      ${message.created_at}
    </div>
  </div>
  <div class="message-body">
    ${content_html}
    ${image_html}
  </div>
</div>
`

  return html;
}
