import $ from 'jquery'
import axios from 'modules/axios'
// import axios from 'axios'
// import { csrfToken } from 'rails-ujs'

// axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

const listenInactiveHeartEvent = (articleId) => {
  $('.inactive-heart').on('click', () => {
    axios.post(`/articles/${articleId}/like`)
      .then((response) => {
        if (response.data.status === 'ok') {
          $('.active-heart').removeClass('hidden')
          $('.inactive-heart').addClass('hidden')
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })
}
// inactivehertのイベントが起きているかどうか
    // errorを表示
    // .thenはうまくいったら

const listenActiveHeartEvent = (articleId) => {
  $('.active-heart').on('click', () => {
    axios.delete(`/articles/${articleId}/like`)
      .then((response) => {
        if (response.data.status === 'ok') {
          $('.active-heart').addClass('hidden')
          $('.inactive-heart').removeClass('hidden')
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })
}
  // console.log(response)
  // errorを表示
    // .thenはうまくいったら

export {
  listenInactiveHeartEvent,
  listenActiveHeartEvent
}
// 省略できる
// listenInactiveHeartEvent: listenInactiveHeartEvent,
// listenActiveHeartEvent: listenActiveHeartEvent
// 渡したいメソッドにメソッド？
// inportとexport