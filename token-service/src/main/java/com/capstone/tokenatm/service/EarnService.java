package com.capstone.tokenatm.service;

import antlr.Token;
import com.capstone.tokenatm.entity.TokenCountEntity;
import com.capstone.tokenatm.exceptions.InternalServerException;
import com.capstone.tokenatm.service.Response.UpdateTokenResponse;
import org.springframework.boot.configurationprocessor.json.JSONException;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;

import java.io.IOException;
import java.util.*;

public interface EarnService {

    HashMap<Object, Object> getStudentGrades() throws IOException, JSONException;

    Map<String, Object> getCourseData() throws IOException, JSONException;

    Map<String, Double> getStudentTokenGrades() throws IOException, JSONException;

    @Retryable(value = InternalServerException.class, maxAttempts = 10, backoff = @Backoff(delay = 1_000))
    Set<String> getSurveyCompletions(String surveyId) throws InternalServerException;

    String getIdentity() throws IOException, JSONException;

    Iterable<TokenCountEntity> getAllStudentTokenCounts();

    Optional<TokenCountEntity> getStudentTokenCount(String user_id);

    void syncTokensOnDeadline() throws JSONException, IOException;

    Iterable<TokenCountEntity> manualSyncTokens() throws JSONException, IOException;

    String spendToken(String user_id, String assignment_id, Integer cost) throws IOException;

    List<AssignmentStatus> getAssignmentStatuses(String user_id) throws JSONException, IOException;

    UpdateTokenResponse updateToken(String user_id, Integer tokenNum);
}

