## Logout Navigation Fix
**Issue**: Bottom navigation persisted after logout
**Cause**: Incomplete navigation stack clearance
**Solution**:
- Use `Navigator.pushNamedAndRemoveUntil` with `rootNavigator: true`
- Clear all routes with `(route) => false` predicate
- Ensures complete widget tree reconstruction