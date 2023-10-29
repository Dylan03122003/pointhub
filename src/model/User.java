package model;

public class User {
	protected int userID;
	private String firstName;
	private String lastName;
	protected String username;
	protected String email;
	private String password;
	protected String photo;
	private String role;
	private String about;
	private String facebookLink;
	private String twitterLink;
	private String instagramLink;
	private String githubLink;
	private int totalQuestions;
	private String ward;
	private String district;
	private String province;
	private boolean isFollowedByCurrentUser;
	private int numberOfFollowers;

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

	/**
	 * Get user profile
	 * 
	 * @param userID
	 * @param username
	 * @param email
	 * @param photo
	 * @param about
	 * @param facebookLink
	 * @param twitterLink
	 * @param instagramLink
	 * @param githubLink
	 * @param totalQuestions
	 */
	public User(int userID, String username, String email, String photo,
			String about, String facebookLink, String twitterLink,
			String instagramLink, String githubLink, int totalQuestions) {
		this.userID = userID;
		this.username = username;
		this.email = email;
		this.photo = photo;
		this.about = about;
		this.facebookLink = facebookLink;
		this.twitterLink = twitterLink;
		this.instagramLink = instagramLink;
		this.githubLink = githubLink;
		this.totalQuestions = totalQuestions;
	}

	// Used for retrieve user profile for updating
	public User(int userID, String firstName, String lastName, String email,
			String photo, String about, String facebookLink, String twitterLink,
			String instagramLink, String githubLink, int totalQuestions,
			String ward, String district, String province) {
		super();
		this.userID = userID;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.photo = photo;
		this.about = about;
		this.facebookLink = facebookLink;
		this.twitterLink = twitterLink;
		this.instagramLink = instagramLink;
		this.githubLink = githubLink;
		this.totalQuestions = totalQuestions;
		this.ward = ward;
		this.district = district;
		this.province = province;
	}
	
	// This is the new updated object when user submit update
	public User(int userID, String firstName, String lastName, String email,
			String about, String facebookLink, String twitterLink,
			String instagramLink, String githubLink, String ward,
			String district, String province) {
		this.userID = userID;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.about = about;
		this.facebookLink = facebookLink;
		this.twitterLink = twitterLink;
		this.instagramLink = instagramLink;
		this.githubLink = githubLink;
		this.ward = ward;
		this.district = district;
		this.province = province;
	}
	
	// Used for getTopFivePopularUsers
	public User(int userID, String username, String photo,
			int numberOfFollowers) {
		this.userID = userID;
		this.username = username;
		this.photo = photo;
		this.numberOfFollowers = numberOfFollowers;
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
		if (email.length() >= 20) {
			return email.substring(0, 20) + "...";
		} else {
			return email;
		}
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

	public User(String firstName, String lastName, String email,
			String password, String role) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.password = password;
		this.role = role;
	}

	public String getAbout() {
		if (about == null) {
			return "";
		}
		return about;
	}

	public void setAbout(String about) {
		this.about = about;
	}

	public String getFacebookLink() {
		if (facebookLink == null) {
			return "";
		}
		return facebookLink;
	}

	public void setFacebookLink(String facebookLink) {
		this.facebookLink = facebookLink;
	}

	public String getTwitterLink() {
		if (twitterLink == null) {
			return "";
		}
		return twitterLink;
	}

	public void setTwitterLink(String twitterLink) {
		this.twitterLink = twitterLink;
	}

	public String getInstagramLink() {
		if (instagramLink == null) {
			return "";
		}
		return instagramLink;
	}

	public void setInstagramLink(String instagramLink) {
		this.instagramLink = instagramLink;
	}

	public String getGithubLink() {
		if (githubLink == null) {
			return "";
		}
		return githubLink;
	}

	public void setGithubLink(String githubLink) {
		this.githubLink = githubLink;
	}

	public int getTotalQuestions() {
		return totalQuestions;
	}

	public void setTotalQuestions(int totalQuestions) {
		this.totalQuestions = totalQuestions;
	}

	public String getWard() {
		if (ward == null) {
			return "";
		}
		return ward;
	}

	public void setWard(String ward) {
		this.ward = ward;
	}

	public String getDistrict() {
		if (district == null) {
			return "";
		}
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getProvince() {
		if (province == null) {
			return "";
		}
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public boolean isFollowedByCurrentUser() {
		return isFollowedByCurrentUser;
	}

	public void setFollowedByCurrentUser(boolean isFollowedByCurrentUser) {
		this.isFollowedByCurrentUser = isFollowedByCurrentUser;
	}

	public int getNumberOfFollowers() {
		return numberOfFollowers;
	}

	public void setNumberOfFollowers(int numberOfFollowers) {
		this.numberOfFollowers = numberOfFollowers;
	}

	@Override
	public String toString() {
		return "User [userID=" + userID + ", firstName=" + firstName
				+ ", lastName=" + lastName + ", username=" + username
				+ ", email=" + email + ", password=" + password + ", photo="
				+ photo + ", role=" + role + ", about=" + about
				+ ", facebookLink=" + facebookLink + ", twitterLink="
				+ twitterLink + ", instagramLink=" + instagramLink
				+ ", githubLink=" + githubLink + ", totalQuestions="
				+ totalQuestions + ", ward=" + ward + ", district=" + district
				+ ", province=" + province + "]";
	}

}
