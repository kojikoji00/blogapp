import $ from 'jquery'
import axios from 'modules/axios'
import {
  listenInactiveHeartEvent,
  listenActiveHeartEvent
} from 'modules/handle_heart'

// axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()
// 勝手にpostされてしまうと困るから鍵をつける 鍵を渡すcsrf-token

// 可読性
const handleHeartDisplay = (hasLiked) => {
  if (hasLiked) {
    $('.active-heart').removeClass('hidden')
  } else {
    $('.inactive-heart').removeClass('hidden')
  }
}

const handleCommentForm = () => {
  $('.show-comment-form').on('click', () => {
    $('.show-comment-form').addClass('hidden')
    $('.comment-text-area').removeClass('hidden')
  })
}

const appendNewComment = (comment) => {
  $('.comments-container').append(
    `<div class="article_comment"><p>${comment.content}</p></div>`
  )
}

// document.addEventListener('DOMContentLoaded', () => {
document.addEventListener('DOMContentLoaded', () => {
  const dataset = $('#article-show').data()
  const articleId = dataset.articleId

  axios.get(`/articles/${articleId}/comments`)
    .then((response) => {
      const comments = response.data
      comments.forEach((comment) => {
        appendNewComment(comment)
        // $('.comments-container').append(
        //   `<div class="article_comment><p>${comment.content}</p></div>`
        // )
        // append = htmlを挿入していく
        // divタグの中にpタグ
      })
    })

  handleCommentForm()
    // デベロッパーツールで確認classになっているコメントコンテントを渡す
  //  コメントコンテントのvalueを渡す
  $('.add-comment-button').on('click', () => {
    const content = $('#comment_content').val()
    if (!content) {
      window.alert('コメントを入力してください')
    } else {
      axios.post(`/articles/${articleId}/comments`, {
        comment: {content: content}
        // 第二引数
      })
        .then((res) => {
          const comment = res.data
          appendNewComment(comment)
          $('#comment_content').val('')
        })
    }
  })



  axios.get(`/articles/${articleId}/like`)
    .then((response) => {
      const hasLiked = response.data.hasLiked
      handleHeartDisplay(hasLiked)
    })
  listenInactiveHeartEvent(articleId)
  listenActiveHeartEvent(articleId)
    // })
})
  // $('.article_title').on('click', () => {
  //   axios.get('/')
  //   .then((response) => {
  //     console.log(response)
  //   })
  
    // DOMContentLoadedはリロードした時に起こる
    // ターボリンクスが働いている.railsならでは
    // ルートに送る
// eventが起こったら関数を実行
// onも同様アクションが起こったら実行する

// どのファイルを読み込ませるか
