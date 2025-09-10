package com.bishal.invoice

import android.content.Context
import android.util.Log
import com.google.android.play.core.integrity.IntegrityManagerFactory
import com.google.android.play.core.integrity.IntegrityTokenRequest
import com.google.android.play.core.integrity.IntegrityTokenResponse
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.tasks.await
import kotlinx.coroutines.withContext

/**
 * Helper class for Play Integrity API integration.
 * Replaces the deprecated SafetyNet Attestation API.
 */
class PlayIntegrityHelper(private val context: Context) {
    private val TAG = "PlayIntegrityHelper"
    
    /**
     * Request an integrity token from the Play Integrity API.
     * 
     * @param nonce A nonce value to include in the request for verification
     * @return The integrity token as a String, or null if the request failed
     */
    suspend fun requestIntegrityToken(nonce: String): String? = withContext(Dispatchers.IO) {
        try {
            val integrityManager = IntegrityManagerFactory.create(context)
            
            // Prepare the request with the nonce
            val request = IntegrityTokenRequest.builder()
                .setNonce(nonce)
                .build()
            
            // Request the token
            val response = integrityManager.requestIntegrityToken(request).await()
            
            // Return the token
            return@withContext response.token()
        } catch (e: Exception) {
            Log.e(TAG, "Error requesting integrity token: ${e.message}")
            return@withContext null
        }
    }
}