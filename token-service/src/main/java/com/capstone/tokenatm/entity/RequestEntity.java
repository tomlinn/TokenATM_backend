package com.capstone.tokenatm.entity;

import javax.persistence.*;

@Entity
@Table(name = "Requests")
public class RequestEntity {
	private String studentId;
	private String assignmentId;
	private int tokenCount;
	private boolean isApproved;

	private String status;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer id;

	public RequestEntity(String studentId, String assignmentId, int tokenCount, String status) {
		this.studentId = studentId;
		this.assignmentId = assignmentId;
		this.tokenCount = tokenCount;
		this.isApproved = false;
		this.status = status;
	}

	public RequestEntity() {

	}

	public String getStudentId() {
		return this.studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	public String getAssignmentId() {
		return this.assignmentId;
	}

	public void setAssignmentId(String assignmentId) {
		this.assignmentId = assignmentId;
	}

	public int getTokenCount() {
		return this.tokenCount;
	}

	public void setTokenCount(int tokenCount) {
		this.tokenCount = tokenCount;
	}

	public boolean isApproved() {
		return this.isApproved;
	}

	public void setApproved(boolean approved) {
		this.isApproved = approved;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}


	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return id;
	}
}

