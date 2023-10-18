package model;

public class User {
	private int userID;
	private String firstName;
	private String lastName;
	private String username;
	private String email;
	private String password;
    private String photo;
    private String role;
	 
	public User() {
		
	}

	public User(int userID, String username, String email, String photo) {
		this.userID = userID;
		this.username = username;
		this.email = email;
		this.photo = photo;
	}

	public User(int userID, String firstName, String lastName, String email,
			String password) {
		this.userID = userID;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.password = password;
		this.username = this.lastName + this.firstName;

	}

	public User(String firstName, String lastName, String email,
			String password) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.password = password;
		this.username = this.lastName + this.firstName;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public User(String firstName, String lastName,
			String email, String password, String role) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.password = password;
		this.role = role;
	}

	@Override
	public String toString() {
		return "User [userID=" + userID + ", firstName=" + firstName
				+ ", lastName=" + lastName + ", email=" + email + ", password="
				+ password + "]";
	}

}
