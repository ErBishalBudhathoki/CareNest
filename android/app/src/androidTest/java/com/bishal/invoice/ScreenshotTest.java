package com.bishal.invoice;

import static androidx.test.espresso.Espresso.onView;
import static androidx.test.espresso.action.ViewActions.click;
import static androidx.test.espresso.matcher.ViewMatchers.withText;
import static androidx.test.espresso.Espresso.pressBack;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import androidx.test.platform.app.InstrumentationRegistry;
import androidx.test.rule.ActivityTestRule;
import androidx.test.ext.junit.runners.AndroidJUnit4;
import androidx.test.uiautomator.UiDevice;
import androidx.test.uiautomator.UiObject;
import androidx.test.uiautomator.UiSelector;

import org.junit.ClassRule;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;

import tools.fastlane.screengrab.Screengrab;
import tools.fastlane.screengrab.locale.LocaleTestRule;
import tools.fastlane.screengrab.UiAutomatorScreenshotStrategy;

import androidx.test.uiautomator.UiScrollable;

@RunWith(AndroidJUnit4.class)
public class ScreenshotTest {
    // TODO: Update these credentials with a valid test account
    private static final String TEST_EMAIL = "test@tester.com";
    private static final String TEST_PASSWORD = "111111"; 

    @ClassRule
    public static final LocaleTestRule localeTestRule = new LocaleTestRule();

    @Rule
    public ActivityTestRule<MainActivity> activityRule = new ActivityTestRule<>(MainActivity.class, true, false);

    @Test
    public void testTakeScreenshot() throws Exception {
        UiDevice device = UiDevice.getInstance(InstrumentationRegistry.getInstrumentation());

        // Manually launch activity without waiting for idle (Flutter never idles)
        Context context = InstrumentationRegistry.getInstrumentation().getTargetContext();
        Intent intent = new Intent(context, MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(intent);
        
        // Use UiAutomator strategy
        Screengrab.setDefaultScreenshotStrategy(new UiAutomatorScreenshotStrategy());
        
        Screengrab.screenshot("00_init");

        // 1. Login Screen
        Thread.sleep(15000); 
        Screengrab.screenshot("01_login_screen");

        // Attempt Login
        // Find Email Field (EditText instance 0 usually)
        UiObject emailField = device.findObject(new UiSelector().className("android.widget.EditText").instance(0));
        if (emailField.exists()) {
            emailField.click();
            emailField.setText(TEST_EMAIL);
            device.pressBack(); // Close keyboard
        } else {
            // Try searching by text content if it has hint
            UiObject emailHint = device.findObject(new UiSelector().textContains("Email"));
            if (emailHint.exists()) {
                emailHint.click();
                emailHint.setText(TEST_EMAIL);
                device.pressBack();
            }
        }

        // Find Password Field (EditText instance 1 usually)
        UiObject passwordField = device.findObject(new UiSelector().className("android.widget.EditText").instance(1));
        if (passwordField.exists()) {
            passwordField.click();
            passwordField.setText(TEST_PASSWORD);
            device.pressBack(); // Close keyboard
        }

        Screengrab.screenshot("01_b_filled_form");

        // Click Sign In (Button instance 0 or find by text)
        UiObject signInButton = device.findObject(new UiSelector().descriptionContains("Sign in"));
        if (!signInButton.exists()) {
            signInButton = device.findObject(new UiSelector().textContains("Sign in"));
        }
        if (!signInButton.exists()) {
                // Try case insensitive manually or just other variants
                signInButton = device.findObject(new UiSelector().descriptionContains("Sign In"));
        }
        if (!signInButton.exists()) {
                     signInButton = device.findObject(new UiSelector().className("android.widget.Button").descriptionContains("Sign in"));
                }
                if (!signInButton.exists()) {
                     signInButton = device.findObject(new UiSelector().className("android.widget.Button").instance(0));
                }

                if (signInButton.exists()) {
                    signInButton.click();
            Screengrab.screenshot("01_c_clicked_button");
            
            // Wait for login (Home screen)
            Thread.sleep(15000);
            Screengrab.screenshot("04_home_dashboard");

            // --- Capture Full Dashboard (Scroll Down) ---
            // Scroll down a bit to capture below the fold
            device.swipe(500, 1500, 500, 500, 20); // Swipe up
            Thread.sleep(2000);
            Screengrab.screenshot("04_b_home_dashboard_scrolled");

             // Scroll more
            device.swipe(500, 1500, 500, 500, 20); // Swipe up
            Thread.sleep(2000);
            Screengrab.screenshot("04_c_home_dashboard_scrolled_more");
            
            // Scroll back to top
            device.swipe(500, 500, 500, 1500, 20);
            device.swipe(500, 500, 500, 1500, 20);
            Thread.sleep(2000);

            // --- Navigation Loop ---
            // Try to click visible action cards
            
            // Time Clock (Not found in previous run, maybe "Manage shifts" or similar?)
            // Based on code: "Schedule", "Requests", "Holiday List", "View Assignments", "Employee Tracking", "Mileage Tracker", "Onboarding"
            
            // Schedule
            clickAndScreenshot(device, "Schedule", "05_schedule_dashboard");
            
            // Requests
            clickAndScreenshot(device, "Requests", "06_requests_dashboard");

             // Employee Tracking
            clickAndScreenshot(device, "Employee Tracking", "07_employee_tracking");
            
            // Training & Compliance (Category header, not clickable, items inside are)
            // "Audit Certifications", "Manage Training", "Compliance Checklists"
            clickAndScreenshot(device, "Audit Certifications", "08_audit_certifications");
            
            // Expenses -> "Expense Management"
            clickAndScreenshot(device, "Expense Management", "09_expense_management");
            
            // Mileage -> "Mileage Tracker"
            clickAndScreenshot(device, "Mileage Tracker", "10_mileage_tracker");

            // Earnings -> "Earnings Dashboard"
            clickAndScreenshot(device, "Earnings Dashboard", "11_earnings_dashboard");
            
        } else {
            System.out.println("Sign In button not found");
            throw new RuntimeException("Sign In button not found");
        }
    }

    private void clickAndScreenshot(UiDevice device, String text, String screenshotName) {
        try {
            System.out.println("Attempting to capture: " + text);
            
            // 1. Try to find visible item first
            UiObject item = findItemByTextOrDesc(device, text);
            
            // 2. If not found, try SWIPING UP (scrolling down)
            if (!item.exists()) {
                System.out.println("Item " + text + " not visible. Swiping up...");
                for (int i = 0; i < 5; i++) { // Swipe max 5 times
                    device.swipe(500, 1500, 500, 500, 20); // Swipe up
                    Thread.sleep(1000);
                    item = findItemByTextOrDesc(device, text);
                    if (item.exists()) break;
                }
            }

            // 3. If STILL not found, try SWIPING DOWN (scrolling up)
            if (!item.exists()) {
                System.out.println("Item " + text + " not found, swiping down to top...");
                 for (int i = 0; i < 7; i++) { // Swipe max 7 times
                    device.swipe(500, 500, 500, 1500, 20); // Swipe down
                    Thread.sleep(1000);
                     item = findItemByTextOrDesc(device, text);
                    if (item.exists()) break;
                }
            }
            
            if (item.exists()) {
                System.out.println("Found item: " + text + ". Clicking...");
                item.click();
                Thread.sleep(8000); // Wait for navigation
                Screengrab.screenshot(screenshotName);
                device.pressBack(); // Go back to home
                Thread.sleep(3000); // Wait for home
            } else {
                System.out.println("Could not find item: " + text + " after comprehensive search.");
            }
        } catch (Exception e) {
            System.out.println("Error capturing " + screenshotName + ": " + e.getMessage());
            e.printStackTrace();
        }
    }

    private UiObject findItemByTextOrDesc(UiDevice device, String text) {
        UiObject item = device.findObject(new UiSelector().descriptionContains(text));
        if (!item.exists()) {
            item = device.findObject(new UiSelector().textContains(text));
        }
        return item;
    }
}