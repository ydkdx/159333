document.addEventListener('DOMContentLoaded', function() {
    const userId = 1;

    fetch(`/api/profile?userId=${userId}`)
        .then(response => response.json())
        .then(data => {
            if (data) {
                document.getElementById('profile-picture').src = data.profile_picture || 'default.jpg';
                document.getElementById('user-name').textContent = data.full_name || 'User';
            } else {
                console.error('Profile not found');
            }
        })
        .catch(error => console.error('Error:', error));
});
