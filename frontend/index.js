document.addEventListener('DOMContentLoaded', function() {
    // 假设用户名存储在浏览器的本地存储中
    const username = localStorage.getItem('username') || 'Guest';
    document.getElementById('username').textContent = username;
});
