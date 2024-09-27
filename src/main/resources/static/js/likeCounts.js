document.addEventListener("DOMContentLoaded", function() {
    const likeBtn = document.getElementById('like-btn');
    const likeCountElement = document.getElementById('like-count');
    const postId = likeBtn.getAttribute('data-post-id');


    let isLiked = localStorage.getItem(`post-${postId}-liked`) === 'true';
    updateLikeButton(isLiked);


    likeBtn.addEventListener('click', function() {
        if (isLiked) {
            unlikePost(postId, likeCountElement);
        } else {
            likePost(postId, likeCountElement);
        }


        isLiked = !isLiked;
        updateLikeButton(isLiked);


        localStorage.setItem(`post-${postId}-liked`, isLiked);
    });
});


function likePost(postId, likeCountElement) {
    let currentLikes = parseInt(likeCountElement.textContent);
    currentLikes += 1;
    likeCountElement.textContent = `${currentLikes} лайков`;


    fetch(`/posts/${postId}/like`, { method: 'POST' })
        .then(response => response.json())
        .then(data => console.log('Лайк добавлен'));
}


function unlikePost(postId, likeCountElement) {
    let currentLikes = parseInt(likeCountElement.textContent);
    currentLikes -= 1;
    likeCountElement.textContent = `${currentLikes} лайков`;


    fetch(`/posts/${postId}/dislike`, { method: 'POST' })
        .then(response => response.json())
        .then(data => console.log('Лайк удален'));
}

function updateLikeButton(isLiked) {
    const likeBtn = document.getElementById('like-btn');
    if (isLiked) {
        likeBtn.textContent = 'Убрать лайк';
        likeBtn.style.backgroundColor = 'red';
    } else {
        likeBtn.textContent = 'Лайк';
        likeBtn.style.backgroundColor = '';
    }
}