// profile.js
document.getElementById('profile-form').addEventListener('submit', function(event) {
    event.preventDefault();

    const formData = new FormData(this);

    fetch('/api/update-profile', {
        method: 'POST',
        body: JSON.stringify({
            user_id: formData.get('user_id'),
            full_name: formData.get('full_name'),
            email: formData.get('email'),
            job_preferences: formData.get('job_preferences')
        }),
        headers: {
            'Content-Type': 'application/json'
        }
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('Profile updated successfully!');
            } else {
                alert('Error updating profile.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error updating profile.');
        });
});
