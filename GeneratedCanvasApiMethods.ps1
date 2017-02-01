<#

 These files were generated with the CanvasApiGenerator, and any methods containing errors
 were just disabled with comment blocks for now.

 https://github.com/squid808/
 Use at your own risk and stuff


#> 

<#
.Synopsis
   Search account domains 
.DESCRIPTION
   Returns a list of up to 5 matching account domains Partial match on name / domain are supported
.EXAMPLE
   PS C:> Get-CanvasAccountsSearch -name $SomenameObj -domain $SomedomainObj -latitude $SomelatitudeObj -longitude $SomelongitudeObj
#>
function Get-CanvasAccountsSearch {
[CmdletBinding()]

	Param
	(
        # campus name
        [Parameter(Mandatory=$false)]
        $name,

        # no description
        [Parameter(Mandatory=$false)]
        $domain,

        # no description
        [Parameter(Mandatory=$false)]
        $latitude,

        # no description
        [Parameter(Mandatory=$false)]
        $longitude
	)

    $uri = "/api/v1/accounts/search" 

	$Body = @{}

	if ($name) {$Body["name"] = $name}

	if ($domain) {$Body["domain"] = $domain}

	if ($latitude) {$Body["latitude"] = $latitude}

	if ($longitude) {$Body["longitude"] = $longitude}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Index of active global notification for the user 
.DESCRIPTION
   Returns a list of all global notifications in the account for this user Any notifications that have been closed by the user will not be returned
.EXAMPLE
   PS C:> Get-CanvasAccountsUsersAccountNotifications -AccountId $SomeAccountIdObj -UserId $SomeUserIdObj
#>
function Get-CanvasAccountsUsersAccountNotifications {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId
	)

    $uri = "/api/v1/accounts/{0}/users/{1}/account_notifications" -f $AccountId, $UserId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Show a global notification 
.DESCRIPTION
   Returns a global notification A notification that has been closed by the user will not be returned
.EXAMPLE
   PS C:> Get-CanvasAccountsUsersAccountNotifications -AccountId $SomeAccountIdObj -UserId $SomeUserIdObj -Id $SomeIdObj
#>
function Get-CanvasAccountsUsersAccountNotifications {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/accounts/{0}/users/{1}/account_notifications/{2}" -f $AccountId, $UserId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Close notification for user 
.DESCRIPTION
   If the user no long wants to see this notification it can be excused with this call
.EXAMPLE
   PS C:> Delete-CanvasAccountsUsersAccountNotifications -AccountId $SomeAccountIdObj -UserId $SomeUserIdObj -Id $SomeIdObj
#>
function Delete-CanvasAccountsUsersAccountNotifications {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/accounts/{0}/users/{1}/account_notifications/{2}" -f $AccountId, $UserId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Create a global notification 
.DESCRIPTION
   Create and return a new global notification for an account.
.EXAMPLE
   PS C:> Post-CanvasAccountsAccountNotifications -AccountId $SomeAccountIdObj -Subject $SomeSubjectObj -Message $SomeMessageObj -StartAt $SomeStartAtObj -EndAt $SomeEndAtObj -Icon $SomeIconObj -AccountNotificationRoles $SomeAccountNotificationRolesObj
#>
function Post-CanvasAccountsAccountNotifications {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The subject of the notification.
        [Parameter(Mandatory=$true)]
        $Subject,

        # The message body of the notification.
        [Parameter(Mandatory=$true)]
        $Message,

        # The start date and time of the notification in ISO8601 format. e.g. 2014-01-01T01:00Z
        [Parameter(Mandatory=$true)]
        $StartAt,

        # The end date and time of the notification in ISO8601 format. e.g. 2014-01-01T01:00Z
        [Parameter(Mandatory=$true)]
        $EndAt,

        # The icon to display with the notification. Note: Defaults to warning.
		#Allowed values: warning, information, question, error, calendar 
        [Parameter(Mandatory=$false)]
        $Icon,

        # The role(s) to send global notification to. Note: ommitting this field will send to everyone Example:
		#account_notification_roles: ["StudentEnrollment", "TeacherEnrollment"]
        [Parameter(Mandatory=$false)]
        $AccountNotificationRoles
	)

    $uri = "/api/v1/accounts/{0}/account_notifications" -f $AccountId 

	$Body = @{}

	$Body["account_notification[subject]"] = $Subject

	$Body["account_notification[message]"] = $Message

	$Body["account_notification[start_at]"] = $StartAt

	$Body["account_notification[end_at]"] = $EndAt

	if ($Icon) {$Body["account_notification[icon]"] = $Icon}

	if ($AccountNotificationRoles) {$Body["account_notification_roles[]"] = $AccountNotificationRoles}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Update a global notification 
.DESCRIPTION
   Update global notification for an account.
.EXAMPLE
   PS C:> Put-CanvasAccountsAccountNotifications -AccountId $SomeAccountIdObj -Id $SomeIdObj -Subject $SomeSubjectObj -Message $SomeMessageObj -StartAt $SomeStartAtObj -EndAt $SomeEndAtObj -Icon $SomeIconObj -AccountNotificationRoles $SomeAccountNotificationRolesObj
#>
function Put-CanvasAccountsAccountNotifications {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The subject of the notification.
        [Parameter(Mandatory=$false)]
        $Subject,

        # The message body of the notification.
        [Parameter(Mandatory=$false)]
        $Message,

        # The start date and time of the notification in ISO8601 format. e.g. 2014-01-01T01:00Z
        [Parameter(Mandatory=$false)]
        $StartAt,

        # The end date and time of the notification in ISO8601 format. e.g. 2014-01-01T01:00Z
        [Parameter(Mandatory=$false)]
        $EndAt,

        # The icon to display with the notification.
		#Allowed values: warning, information, question, error, calendar 
        [Parameter(Mandatory=$false)]
        $Icon,

        # The role(s) to send global notification to. Note: ommitting this field will send to everyone Example:
		#account_notification_roles: ["StudentEnrollment", "TeacherEnrollment"]
        [Parameter(Mandatory=$false)]
        $AccountNotificationRoles
	)

    $uri = "/api/v1/accounts/{0}/account_notifications/{1}" -f $AccountId, $Id 

	$Body = @{}

	if ($Subject) {$Body["account_notification[subject]"] = $Subject}

	if ($Message) {$Body["account_notification[message]"] = $Message}

	if ($StartAt) {$Body["account_notification[start_at]"] = $StartAt}

	if ($EndAt) {$Body["account_notification[end_at]"] = $EndAt}

	if ($Icon) {$Body["account_notification[icon]"] = $Icon}

	if ($AccountNotificationRoles) {$Body["account_notification_roles[]"] = $AccountNotificationRoles}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   List Available Reports 
.DESCRIPTION
   Returns the list of reports for the current context.
.EXAMPLE
   PS C:> Get-CanvasAccountsReports -AccountId $SomeAccountIdObj
#>
function Get-CanvasAccountsReports {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId
	)

    $uri = "/api/v1/accounts/{0}/reports" -f $AccountId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Start a Report 
.DESCRIPTION
   Generates a report instance for the account.
.EXAMPLE
   PS C:> Post-CanvasAccountsReports -AccountId $SomeAccountIdObj -Report $SomeReportObj -Parameters $SomeParametersObj
#>
function Post-CanvasAccountsReports {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Report
        [Parameter(Mandatory=$true)]
        $Report,

        # The parameters will vary for each report
        [Parameter(Mandatory=$false)]
        $Parameters
	)

    $uri = "/api/v1/accounts/{0}/reports/{1}" -f $AccountId, $Report 

	$Body = @{}

	if ($Parameters) {$Body["[parameters]"] = $Parameters}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Index of Reports 
.DESCRIPTION
   Shows all reports that have been run for the account of a specific type.
.EXAMPLE
   PS C:> Get-CanvasAccountsReports -AccountId $SomeAccountIdObj -Report $SomeReportObj
#>
function Get-CanvasAccountsReports {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Report
        [Parameter(Mandatory=$true)]
        $Report
	)

    $uri = "/api/v1/accounts/{0}/reports/{1}" -f $AccountId, $Report 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Status of a Report 
.DESCRIPTION
   Returns the status of a report.
.EXAMPLE
   PS C:> Get-CanvasAccountsReports -AccountId $SomeAccountIdObj -Report $SomeReportObj -Id $SomeIdObj
#>
function Get-CanvasAccountsReports {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Report
        [Parameter(Mandatory=$true)]
        $Report,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/accounts/{0}/reports/{1}/{2}" -f $AccountId, $Report, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Delete a Report 
.DESCRIPTION
   Deletes a generated report instance.
.EXAMPLE
   PS C:> Delete-CanvasAccountsReports -AccountId $SomeAccountIdObj -Report $SomeReportObj -Id $SomeIdObj
#>
function Delete-CanvasAccountsReports {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Report
        [Parameter(Mandatory=$true)]
        $Report,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/accounts/{0}/reports/{1}/{2}" -f $AccountId, $Report, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   List accounts 
.DESCRIPTION
   List accounts that the current user can view or manage. Typically, students and even teachers will get an empty list in response, only account admins can view the accounts that they are in.
.EXAMPLE
   PS C:> Get-CanvasAccounts -Include $SomeIncludeObj
#>
function Get-CanvasAccounts {
[CmdletBinding()]

	Param
	(
        # Array of additional information to include.
		#âlti_guidâ 
		#the 'tool_consumer_instance_guid' that will be sent for this account on LTI launches
		#âregistration_settingsâ 
		#returns info about the privacy policy and terms of use
		#âservicesâ 
		#returns services and whether they are enabled (requires account management permissions)
		#Allowed values: lti_guid, registration_settings, services 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/accounts" 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List accounts for course admins 
.DESCRIPTION
   List accounts that the current user can view through their admin course enrollments. (Teacher, TA, or designer enrollments). Only returns âidâ, ânameâ, âworkflow_stateâ, âroot_account_idâ and âparent_account_idâ
.EXAMPLE
   PS C:> Get-CanvasCourseAccounts
#>
function Get-CanvasCourseAccounts {
[CmdletBinding()]

    $uri = "/api/v1/course_accounts" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get a single account 
.DESCRIPTION
   Retrieve information on an individual account, given by id or sis sis_account_id.
.EXAMPLE
   PS C:> Get-CanvasAccounts -Id $SomeIdObj
#>
function Get-CanvasAccounts {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/accounts/{0}" -f $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get the sub-accounts of an account 
.DESCRIPTION
   List accounts that are sub-accounts of the given account.
.EXAMPLE
   PS C:> Get-CanvasAccountsSubAccounts -AccountId $SomeAccountIdObj -recursive $SomerecursiveObj
#>
function Get-CanvasAccountsSubAccounts {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # If true, the entire account tree underneath this account will be returned (though still paginated). If false, only direct sub-accounts of this account will be returned. Defaults to false.
        [Parameter(Mandatory=$false)]
        $recursive
	)

    $uri = "/api/v1/accounts/{0}/sub_accounts" -f $AccountId 

	$Body = @{}

	if ($recursive) {$Body["recursive"] = $recursive}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List active courses in an account 
.DESCRIPTION
   Retrieve the list of courses in this account.
.EXAMPLE
   PS C:> Get-CanvasAccountsCourses -AccountId $SomeAccountIdObj -with_enrollments $Somewith_enrollmentsObj -EnrollmentType $SomeEnrollmentTypeObj -published $SomepublishedObj -completed $SomecompletedObj -ByTeachers $SomeByTeachersObj -BySubaccounts $SomeBySubaccountsObj -hide_enrollmentless_courses $Somehide_enrollmentless_coursesObj -State $SomeStateObj -enrollment_term_id $Someenrollment_term_idObj -search_term $Somesearch_termObj -Include $SomeIncludeObj
#>
function Get-CanvasAccountsCourses {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # If true, include only courses with at least one enrollment. If false, include only courses with no enrollments. If not present, do not filter on course enrollment status.
        [Parameter(Mandatory=$false)]
        $with_enrollments,

        # If set, only return courses that have at least one user enrolled in in the course with one of the specified enrollment types.
		#Allowed values: teacher, student, ta, observer, designer 
        [Parameter(Mandatory=$false)]
        $EnrollmentType,

        # If true, include only published courses. If false, exclude published courses. If not present, do not filter on published status.
        [Parameter(Mandatory=$false)]
        $published,

        # If true, include only completed courses (these may be in state 'completed', or their enrollment term may have ended). If false, exclude completed courses. If not present, do not filter on completed status.
        [Parameter(Mandatory=$false)]
        $completed,

        # List of User IDs of teachers; if supplied, include only courses taught by one of the referenced users.
        [Parameter(Mandatory=$false)]
        $ByTeachers,

        # List of Account IDs; if supplied, include only courses associated with one of the referenced subaccounts.
        [Parameter(Mandatory=$false)]
        $BySubaccounts,

        # If present, only return courses that have at least one enrollment. Equivalent to 'with_enrollments=true'; retained for compatibility.
        [Parameter(Mandatory=$false)]
        $hide_enrollmentless_courses,

        # If set, only return courses that are in the given state(s). By default, all states but âdeletedâ are returned.
		#Allowed values: created, claimed, available, completed, deleted, all 
        [Parameter(Mandatory=$false)]
        $State,

        # If set, only includes courses from the specified term.
        [Parameter(Mandatory=$false)]
        $enrollment_term_id,

        # The partial course name, code, or full ID to match and return in the results list. Must be at least 3 characters.
        [Parameter(Mandatory=$false)]
        $search_term,

        # All explanations can be seen in the Course API index documentation
		#âsectionsâ, âneeds_grading_countâ and âtotal_scoresâ are not valid options at the account level
		#Allowed values: syllabus_body, term, course_progress, storage_quota_used_mb, total_students, teachers 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/accounts/{0}/courses" -f $AccountId 

	$Body = @{}

	if ($with_enrollments) {$Body["with_enrollments"] = $with_enrollments}

	if ($EnrollmentType) {$Body["enrollment_type[]"] = $EnrollmentType}

	if ($published) {$Body["published"] = $published}

	if ($completed) {$Body["completed"] = $completed}

	if ($ByTeachers) {$Body["by_teachers[]"] = $ByTeachers}

	if ($BySubaccounts) {$Body["by_subaccounts[]"] = $BySubaccounts}

	if ($hide_enrollmentless_courses) {$Body["hide_enrollmentless_courses"] = $hide_enrollmentless_courses}

	if ($State) {$Body["state[]"] = $State}

	if ($enrollment_term_id) {$Body["enrollment_term_id"] = $enrollment_term_id}

	if ($search_term) {$Body["search_term"] = $search_term}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Update an account 
.DESCRIPTION
   Update an existing account.
.EXAMPLE
   PS C:> Put-CanvasAccounts -Id $SomeIdObj -Name $SomeNameObj -DefaultTimeZone $SomeDefaultTimeZoneObj -DefaultStorageQuotaMb $SomeDefaultStorageQuotaMbObj -DefaultUserStorageQuotaMb $SomeDefaultUserStorageQuotaMbObj -DefaultGroupStorageQuotaMb $SomeDefaultGroupStorageQuotaMbObj -Value $SomeValueObj -Locked $SomeLockedObj -Value $SomeValueObj -Locked $SomeLockedObj -Value $SomeValueObj -Locked $SomeLockedObj -Value $SomeValueObj -Locked $SomeLockedObj -Services $SomeServicesObj
#><#
function Put-CanvasAccounts {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Updates the account name
        [Parameter(Mandatory=$false)]
        $Name,

        # The default time zone of the account. Allowed time zones are IANA time zones or friendlier Ruby on Rails time zones.
        [Parameter(Mandatory=$false)]
        $DefaultTimeZone,

        # The default course storage quota to be used, if not otherwise specified.
        [Parameter(Mandatory=$false)]
        $DefaultStorageQuotaMb,

        # The default user storage quota to be used, if not otherwise specified.
        [Parameter(Mandatory=$false)]
        $DefaultUserStorageQuotaMb,

        # The default group storage quota to be used, if not otherwise specified.
        [Parameter(Mandatory=$false)]
        $DefaultGroupStorageQuotaMb,

        # Restrict students from viewing courses after end date
        [Parameter(Mandatory=$false)]
        $Value,

        # Lock this setting for sub-accounts and courses
        [Parameter(Mandatory=$false)]
        $Locked,

        # Restrict students from viewing courses before start date
        [Parameter(Mandatory=$false)]
        $Value,

        # Lock this setting for sub-accounts and courses
        [Parameter(Mandatory=$false)]
        $Locked,

        # Disable comments on announcements
        [Parameter(Mandatory=$false)]
        $Value,

        # Lock this setting for sub-accounts and courses
        [Parameter(Mandatory=$false)]
        $Locked,

        # Restrict students from viewing future enrollments in course list
        [Parameter(Mandatory=$false)]
        $Value,

        # Lock this setting for sub-accounts and courses
        [Parameter(Mandatory=$false)]
        $Locked,

        # Give this a set of keys and boolean values to enable or disable services matching the keys
        [Parameter(Mandatory=$false)]
        $Services
	)

    $uri = "/api/v1/accounts/{0}" -f $Id 

	$Body = @{}

	if ($Name) {$Body["account[name]"] = $Name}

	if ($DefaultTimeZone) {$Body["account[default_time_zone]"] = $DefaultTimeZone}

	if ($DefaultStorageQuotaMb) {$Body["account[default_storage_quota_mb]"] = $DefaultStorageQuotaMb}

	if ($DefaultUserStorageQuotaMb) {$Body["account[default_user_storage_quota_mb]"] = $DefaultUserStorageQuotaMb}

	if ($DefaultGroupStorageQuotaMb) {$Body["account[default_group_storage_quota_mb]"] = $DefaultGroupStorageQuotaMb}

	if ($Value) {$Body["account[settings][restrict_student_past_view][value]"] = $Value}

	if ($Locked) {$Body["account[settings][restrict_student_past_view][locked]"] = $Locked}

	if ($Value) {$Body["account[settings][restrict_student_future_view][value]"] = $Value}

	if ($Locked) {$Body["account[settings][restrict_student_future_view][locked]"] = $Locked}

	if ($Value) {$Body["account[settings][lock_all_announcements][value]"] = $Value}

	if ($Locked) {$Body["account[settings][lock_all_announcements][locked]"] = $Locked}

	if ($Value) {$Body["account[settings][restrict_student_future_listing][value]"] = $Value}

	if ($Locked) {$Body["account[settings][restrict_student_future_listing][locked]"] = $Locked}

	if ($Services) {$Body["account[services]"] = $Services}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}
#>

<#
.Synopsis
   Delete a user from the root account 
.DESCRIPTION
   Delete a user record from a Canvas root account. If a user is associated with multiple root accounts (in a multi-tenant instance of Canvas), this action will NOT remove them from the other accounts. WARNING: This API will allow a user to remove themselves from the account. If they do this, they won't be able to make API calls or log into Canvas at that account.
.EXAMPLE
   PS C:> Delete-CanvasAccountsUsers -AccountId $SomeAccountIdObj -UserId $SomeUserIdObj
#>
function Delete-CanvasAccountsUsers {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId
	)

    $uri = "/api/v1/accounts/{0}/users/{1}" -f $AccountId, $UserId 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Create a new sub-account 
.DESCRIPTION
   Add a new sub-account to a given account.
.EXAMPLE
   PS C:> Post-CanvasAccountsSubAccounts -AccountId $SomeAccountIdObj -Name $SomeNameObj -SisAccountId $SomeSisAccountIdObj -DefaultStorageQuotaMb $SomeDefaultStorageQuotaMbObj -DefaultUserStorageQuotaMb $SomeDefaultUserStorageQuotaMbObj -DefaultGroupStorageQuotaMb $SomeDefaultGroupStorageQuotaMbObj
#>
function Post-CanvasAccountsSubAccounts {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The name of the new sub-account.
        [Parameter(Mandatory=$true)]
        $Name,

        # The account's identifier in the Student Information System.
        [Parameter(Mandatory=$false)]
        $SisAccountId,

        # The default course storage quota to be used, if not otherwise specified.
        [Parameter(Mandatory=$false)]
        $DefaultStorageQuotaMb,

        # The default user storage quota to be used, if not otherwise specified.
        [Parameter(Mandatory=$false)]
        $DefaultUserStorageQuotaMb,

        # The default group storage quota to be used, if not otherwise specified.
        [Parameter(Mandatory=$false)]
        $DefaultGroupStorageQuotaMb
	)

    $uri = "/api/v1/accounts/{0}/sub_accounts" -f $AccountId 

	$Body = @{}

	$Body["account[name]"] = $Name

	if ($SisAccountId) {$Body["account[sis_account_id]"] = $SisAccountId}

	if ($DefaultStorageQuotaMb) {$Body["account[default_storage_quota_mb]"] = $DefaultStorageQuotaMb}

	if ($DefaultUserStorageQuotaMb) {$Body["account[default_user_storage_quota_mb]"] = $DefaultUserStorageQuotaMb}

	if ($DefaultGroupStorageQuotaMb) {$Body["account[default_group_storage_quota_mb]"] = $DefaultGroupStorageQuotaMb}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Make an account admin 
.DESCRIPTION
   Flag an existing user as an admin within the account.
.EXAMPLE
   PS C:> Post-CanvasAccountsAdmins -AccountId $SomeAccountIdObj -user_id $Someuser_idObj -role $SomeroleObj -role_id $Somerole_idObj -send_confirmation $Somesend_confirmationObj
#>
function Post-CanvasAccountsAdmins {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The id of the user to promote.
        [Parameter(Mandatory=$true)]
        $user_id,

        # (deprecated) The user's admin relationship with the account will be created with the given role. Defaults to 'AccountAdmin'.
        [Parameter(Mandatory=$false)]
        $role,

        # The user's admin relationship with the account will be created with the given role. Defaults to the built-in role for 'AccountAdmin'.
        [Parameter(Mandatory=$false)]
        $role_id,

        # Send a notification email to the new admin if true. Default is true.
        [Parameter(Mandatory=$false)]
        $send_confirmation
	)

    $uri = "/api/v1/accounts/{0}/admins" -f $AccountId 

	$Body = @{}

	$Body["user_id"] = $user_id

	if ($role) {$Body["role"] = $role}

	if ($role_id) {$Body["role_id"] = $role_id}

	if ($send_confirmation) {$Body["send_confirmation"] = $send_confirmation}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Remove account admin 
.DESCRIPTION
   Remove the rights associated with an account admin role from a user.
.EXAMPLE
   PS C:> Delete-CanvasAccountsAdmins -AccountId $SomeAccountIdObj -UserId $SomeUserIdObj -role $SomeroleObj -role_id $Somerole_idObj
#>
function Delete-CanvasAccountsAdmins {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # (Deprecated) Account role to remove from the user. Defaults to 'AccountAdmin'. Any other account role must be specified explicitly.
        [Parameter(Mandatory=$false)]
        $role,

        # The user's admin relationship with the account will be created with the given role. Defaults to the built-in role for 'AccountAdmin'.
        [Parameter(Mandatory=$false)]
        $role_id
	)

    $uri = "/api/v1/accounts/{0}/admins/{1}" -f $AccountId, $UserId 

	$Body = @{}

	if ($role) {$Body["role"] = $role}

	if ($role_id) {$Body["role_id"] = $role_id}

    return Get-CanvasApiResult $uri -Method DELETE -RequestParameters $Body
}


<#
.Synopsis
   List account admins 
.DESCRIPTION
   List the admins in the account
.EXAMPLE
   PS C:> Get-CanvasAccountsAdmins -AccountId $SomeAccountIdObj -UserId $SomeUserIdObj
#>
function Get-CanvasAccountsAdmins {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # Scope the results to those with user IDs equal to any of the IDs specified here.
        [Parameter(Mandatory=$false)]
        $UserId
	)

    $uri = "/api/v1/accounts/{0}/admins" -f $AccountId 

	$Body = @{}

	if ($UserId) {$Body["user_id[]"] = $UserId}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get department-level participation data 
.DESCRIPTION
   Returns page view hits summed across all courses in the department. Two groupings of these counts are returned; one by day (by_date), the other by category (by_category). The possible categories are announcements, assignments, collaborations, conferences, discussions, files, general, grades, groups, modules, other, pages, and quizzes. This and the other department-level endpoints have three variations which all return the same style of data but for different subsets of courses. All share the prefix /api/v1/accounts/<account_id>/analytics. The possible suffixes are: Courses not yet offered or which have been deleted are never included. /current and /completed are intended for use when the account has only one term. /terms/<term_id> is intended for use when the account has multiple terms. The action follows the suffix.
.EXAMPLE
   PS C:> Get-CanvasAccountsAnalyticsTermsActivity -AccountId $SomeAccountIdObj -TermId $SomeTermIdObj
#>
function Get-CanvasAccountsAnalyticsTermsActivity {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The TermId
        [Parameter(Mandatory=$true)]
        $TermId
	)

    $uri = "/api/v1/accounts/{0}/analytics/terms/{1}/activity" -f $AccountId, $TermId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get department-level grade data 
.DESCRIPTION
   Returns the distribution of grades for students in courses in the department. Each data point is one student's current grade in one course; if a student is in multiple courses, he contributes one value per course, but if he's enrolled multiple times in the same course (e.g. a lecture section and a lab section), he only constributes on value for that course. Grades are binned to the nearest integer score; anomalous grades outside the 0 to 100 range are ignored. The raw counts are returned, not yet normalized by the total count. Shares the same variations on endpoint as the participation data.
.EXAMPLE
   PS C:> Get-CanvasAccountsAnalyticsTermsGrades -AccountId $SomeAccountIdObj -TermId $SomeTermIdObj
#>
function Get-CanvasAccountsAnalyticsTermsGrades {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The TermId
        [Parameter(Mandatory=$true)]
        $TermId
	)

    $uri = "/api/v1/accounts/{0}/analytics/terms/{1}/grades" -f $AccountId, $TermId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get department-level statistics 
.DESCRIPTION
   Returns numeric statistics about the department and term (or filter). Shares the same variations on endpoint as the participation data.
.EXAMPLE
   PS C:> Get-CanvasAccountsAnalyticsTermsStatistics -AccountId $SomeAccountIdObj -TermId $SomeTermIdObj
#>
function Get-CanvasAccountsAnalyticsTermsStatistics {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The TermId
        [Parameter(Mandatory=$true)]
        $TermId
	)

    $uri = "/api/v1/accounts/{0}/analytics/terms/{1}/statistics" -f $AccountId, $TermId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get course-level participation data 
.DESCRIPTION
   Returns page view hits and participation numbers grouped by day through the entire history of the course. Page views is returned as a hash, where the hash keys are dates in the format âYYYY-MM-DDâ. The page_views result set includes page views broken out by access category. Participations is returned as an array of dates in the format âYYYY-MM-DDâ.
.EXAMPLE
   PS C:> Get-CanvasCoursesAnalyticsActivity -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesAnalyticsActivity {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/analytics/activity" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get course-level assignment data 
.DESCRIPTION
   Returns a list of assignments for the course sorted by due date. For each assignment returns basic assignment information, the grade breakdown, and a breakdown of on-time/late status of homework submissions.
.EXAMPLE
   PS C:> Get-CanvasCoursesAnalyticsAssignments -CourseId $SomeCourseIdObj -async $SomeasyncObj
#>
function Get-CanvasCoursesAnalyticsAssignments {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # If async is true, then the course_assignments call can happen asynch- ronously and MAY return a response containing a progress_url key instead of an assignments array. If it does, then it is the caller's responsibility to poll the API again to see if the progress is complete. If the data is ready (possibly even on the first async call) then it will be passed back normally, as documented in the example response.
        [Parameter(Mandatory=$false)]
        $async
	)

    $uri = "/api/v1/courses/{0}/analytics/assignments" -f $CourseId 

	$Body = @{}

	if ($async) {$Body["async"] = $async}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get course-level student summary data 
.DESCRIPTION
   Returns a summary of per-user access information for all students in a course. This includes total page views, total participations, and a breakdown of on-time/late status for all homework submissions in the course. Each student's summary also includes the maximum number of page views and participations by any student in the course, which may be useful for some visualizations (since determining maximums client side can be tricky with pagination).
.EXAMPLE
   PS C:> Get-CanvasCoursesAnalyticsStudentSummaries -CourseId $SomeCourseIdObj -sort_column $Somesort_columnObj -student_id $Somestudent_idObj
#>
function Get-CanvasCoursesAnalyticsStudentSummaries {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The order results in which results are returned. Defaults to ânameâ.
		#Allowed values: name, name_descending, score, score_descending, participations, participations_descending, page_views, page_views_descending 
        [Parameter(Mandatory=$false)]
        $sort_column,

        # If set, returns only the specified student.
        [Parameter(Mandatory=$false)]
        $student_id
	)

    $uri = "/api/v1/courses/{0}/analytics/student_summaries" -f $CourseId 

	$Body = @{}

	if ($sort_column) {$Body["sort_column"] = $sort_column}

	if ($student_id) {$Body["student_id"] = $student_id}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get user-in-a-course-level participation data 
.DESCRIPTION
   Returns page view hits grouped by hour, and participation details through the entire history of the course. `page_views` are returned as a hash, where the keys are iso8601 dates, bucketed by the hour. `participations` are returned as an array of hashes, sorted oldest to newest.
.EXAMPLE
   PS C:> Get-CanvasCoursesAnalyticsUsersActivity -CourseId $SomeCourseIdObj -StudentId $SomeStudentIdObj
#>
function Get-CanvasCoursesAnalyticsUsersActivity {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The StudentId
        [Parameter(Mandatory=$true)]
        $StudentId
	)

    $uri = "/api/v1/courses/{0}/analytics/users/{1}/activity" -f $CourseId, $StudentId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get user-in-a-course-level assignment data 
.DESCRIPTION
   Returns a list of assignments for the course sorted by due date. For each assignment returns basic assignment information, the grade breakdown (including the student's actual grade), and the basic submission information for the student's submission if it exists.
.EXAMPLE
   PS C:> Get-CanvasCoursesAnalyticsUsersAssignments -CourseId $SomeCourseIdObj -StudentId $SomeStudentIdObj
#>
function Get-CanvasCoursesAnalyticsUsersAssignments {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The StudentId
        [Parameter(Mandatory=$true)]
        $StudentId
	)

    $uri = "/api/v1/courses/{0}/analytics/users/{1}/assignments" -f $CourseId, $StudentId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get user-in-a-course-level messaging data 
.DESCRIPTION
   Returns messaging âhitsâ grouped by day through the entire history of the course. Returns a hash containing the number of instructor-to-student messages, and student-to-instructor messages, where the hash keys are dates in the format âYYYY-MM-DDâ. Message hits include Conversation messages and comments on homework submissions.
.EXAMPLE
   PS C:> Get-CanvasCoursesAnalyticsUsersCommunication -CourseId $SomeCourseIdObj -StudentId $SomeStudentIdObj
#>
function Get-CanvasCoursesAnalyticsUsersCommunication {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The StudentId
        [Parameter(Mandatory=$true)]
        $StudentId
	)

    $uri = "/api/v1/courses/{0}/analytics/users/{1}/communication" -f $CourseId, $StudentId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List external feeds 
.DESCRIPTION
   Returns the list of External Feeds this course or group.
.EXAMPLE
   PS C:> Get-CanvasCoursesExternalFeeds -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesExternalFeeds {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/external_feeds" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create an external feed 
.DESCRIPTION
   Create a new external feed for the course or group.
.EXAMPLE
   PS C:> Post-CanvasCoursesExternalFeeds -CourseId $SomeCourseIdObj -url $SomeurlObj -header_match $Someheader_matchObj -verbosity $SomeverbosityObj
#>
function Post-CanvasCoursesExternalFeeds {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The url to the external rss or atom feed
        [Parameter(Mandatory=$true)]
        $url,

        # If given, only feed entries that contain this string in their title will be imported
        [Parameter(Mandatory=$false)]
        $header_match,

        # Defaults to âfullâ
		#Allowed values: full, truncate, link_only 
        [Parameter(Mandatory=$false)]
        $verbosity
	)

    $uri = "/api/v1/courses/{0}/external_feeds" -f $CourseId 

	$Body = @{}

	$Body["url"] = $url

	if ($header_match) {$Body["header_match"] = $header_match}

	if ($verbosity) {$Body["verbosity"] = $verbosity}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Delete an external feed 
.DESCRIPTION
   Deletes the external feed.
.EXAMPLE
   PS C:> Delete-CanvasCoursesExternalFeeds -CourseId $SomeCourseIdObj -ExternalFeedId $SomeExternalFeedIdObj
#>
function Delete-CanvasCoursesExternalFeeds {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The ExternalFeedId
        [Parameter(Mandatory=$true)]
        $ExternalFeedId
	)

    $uri = "/api/v1/courses/{0}/external_feeds/{1}" -f $CourseId, $ExternalFeedId 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   List announcements 
.DESCRIPTION
   Returns the paginated list of announcements for the given courses and date range. Note that a context_code field is added to the responses so you can tell which course each announcement belongs to.
.EXAMPLE
   PS C:> Get-CanvasAnnouncements -ContextCodes $SomeContextCodesObj -start_date $Somestart_dateObj -end_date $Someend_dateObj -active_only $Someactive_onlyObj
#>
function Get-CanvasAnnouncements {
[CmdletBinding()]

	Param
	(
        # List of context_codes to retrieve announcements for (for example, course_123). Only courses are presently supported. The call will fail unless the caller has View Announcements permission in all listed courses.
        [Parameter(Mandatory=$true)]
        $ContextCodes,

        # Only return announcements posted since the start_date (inclusive). Defaults to 14 days ago. The value should be formatted as: yyyy-mm-dd or ISO 8601 YYYY-MM-DDTHH:MM:SSZ.
        [Parameter(Mandatory=$false)]
        $start_date,

        # Only return announcements posted before the end_date (inclusive). Defaults to 28 days from start_date. The value should be formatted as: yyyy-mm-dd or ISO 8601 YYYY-MM-DDTHH:MM:SSZ. Announcements scheduled for future posting will only be returned to course administrators.
        [Parameter(Mandatory=$false)]
        $end_date,

        # Only return active announcements that have been published. Applies only to requesting users that have permission to view unpublished items. Defaults to false for users with access to view unpublished items, otherwise true and unmodifiable.
        [Parameter(Mandatory=$false)]
        $active_only
	)

    $uri = "/api/v1/announcements" 

	$Body = @{}

	$Body["context_codes[]"] = $ContextCodes

	if ($start_date) {$Body["start_date"] = $start_date}

	if ($end_date) {$Body["end_date"] = $end_date}

	if ($active_only) {$Body["active_only"] = $active_only}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List appointment groups 
.DESCRIPTION
   Retrieve the list of appointment groups that can be reserved or managed by the current user.
.EXAMPLE
   PS C:> Get-CanvasAppointmentGroups -scope $SomescopeObj -ContextCodes $SomeContextCodesObj -include_past_appointments $Someinclude_past_appointmentsObj -Include $SomeIncludeObj
#>
function Get-CanvasAppointmentGroups {
[CmdletBinding()]

	Param
	(
        # Defaults to âreservableâ
		#Allowed values: reservable, manageable 
        [Parameter(Mandatory=$false)]
        $scope,

        # Array of context codes used to limit returned results.
        [Parameter(Mandatory=$false)]
        $ContextCodes,

        # Defaults to false. If true, includes past appointment groups
        [Parameter(Mandatory=$false)]
        $include_past_appointments,

        # Array of additional information to include.
		#âappointmentsâ 
		#calendar event time slots for this appointment group
		#âchild_eventsâ 
		#reservations of those time slots
		#âparticipant_countâ 
		#number of reservations
		#âreserved_timesâ 
		#the event id, start time and end time of reservations the current user has made)
		#âall_context_codesâ 
		#all context codes associated with this appointment group
		#Allowed values: appointments, child_events, participant_count, reserved_times, all_context_codes 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/appointment_groups" 

	$Body = @{}

	if ($scope) {$Body["scope"] = $scope}

	if ($ContextCodes) {$Body["context_codes[]"] = $ContextCodes}

	if ($include_past_appointments) {$Body["include_past_appointments"] = $include_past_appointments}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create an appointment group 
.DESCRIPTION
   Create and return a new appointment group. If new_appointments are specified, the response will return a new_appointments array (same format as appointments array, see âList appointment groupsâ action)
.EXAMPLE
   PS C:> Post-CanvasAppointmentGroups -AppointmentGroup[ContextCodes] $SomeAppointmentGroup[ContextCodes]Obj -AppointmentGroup[SubContextCodes] $SomeAppointmentGroup[SubContextCodes]Obj -Title $SomeTitleObj -Description $SomeDescriptionObj -LocationName $SomeLocationNameObj -LocationAddress $SomeLocationAddressObj -Publish $SomePublishObj -ParticipantsPerAppointment $SomeParticipantsPerAppointmentObj -MinAppointmentsPerParticipant $SomeMinAppointmentsPerParticipantObj -MaxAppointmentsPerParticipant $SomeMaxAppointmentsPerParticipantObj -AppointmentGroup[NewAppointments][X] $SomeAppointmentGroup[NewAppointments][X]Obj -ParticipantVisibility $SomeParticipantVisibilityObj
#><#
function Post-CanvasAppointmentGroups {
[CmdletBinding()]

	Param
	(
        # Array of context codes (courses, e.g. course_1) this group should be linked to (1 or more). Users in the course(s) with appropriate permissions will be able to sign up for this appointment group.
        [Parameter(Mandatory=$true)]
        $AppointmentGroup[ContextCodes],

        # Array of sub context codes (course sections or a single group category) this group should be linked to. Used to limit the appointment group to particular sections. If a group category is specified, students will sign up in groups and the participant_type will be âGroupâ instead of âUserâ.
        [Parameter(Mandatory=$false)]
        $AppointmentGroup[SubContextCodes],

        # Short title for the appointment group.
        [Parameter(Mandatory=$true)]
        $Title,

        # Longer text description of the appointment group.
        [Parameter(Mandatory=$false)]
        $Description,

        # Location name of the appointment group.
        [Parameter(Mandatory=$false)]
        $LocationName,

        # Location address.
        [Parameter(Mandatory=$false)]
        $LocationAddress,

        # Indicates whether this appointment group should be published (i.e. made available for signup). Once published, an appointment group cannot be unpublished. Defaults to false.
        [Parameter(Mandatory=$false)]
        $Publish,

        # Maximum number of participants that may register for each time slot. Defaults to null (no limit).
        [Parameter(Mandatory=$false)]
        $ParticipantsPerAppointment,

        # Minimum number of time slots a user must register for. If not set, users do not need to sign up for any time slots.
        [Parameter(Mandatory=$false)]
        $MinAppointmentsPerParticipant,

        # Maximum number of time slots a user may register for.
        [Parameter(Mandatory=$false)]
        $MaxAppointmentsPerParticipant,

        # Nested array of start time/end time pairs indicating time slots for this appointment group. Refer to the example request.
        [Parameter(Mandatory=$false)]
        $AppointmentGroup[NewAppointments][X],

        # âprivateâ 
		#participants cannot see who has signed up for a particular time slot
		#âprotectedâ 
		#participants can see who has signed up. Defaults to âprivateâ.
		#Allowed values: private, protected 
        [Parameter(Mandatory=$false)]
        $ParticipantVisibility
	)

    $uri = "/api/v1/appointment_groups" 

	$Body = @{}

	$Body["appointment_group[context_codes][]"] = $AppointmentGroup[ContextCodes]

	if ($AppointmentGroup[SubContextCodes]) {$Body["appointment_group[sub_context_codes][]"] = $AppointmentGroup[SubContextCodes]}

	$Body["appointment_group[title]"] = $Title

	if ($Description) {$Body["appointment_group[description]"] = $Description}

	if ($LocationName) {$Body["appointment_group[location_name]"] = $LocationName}

	if ($LocationAddress) {$Body["appointment_group[location_address]"] = $LocationAddress}

	if ($Publish) {$Body["appointment_group[publish]"] = $Publish}

	if ($ParticipantsPerAppointment) {$Body["appointment_group[participants_per_appointment]"] = $ParticipantsPerAppointment}

	if ($MinAppointmentsPerParticipant) {$Body["appointment_group[min_appointments_per_participant]"] = $MinAppointmentsPerParticipant}

	if ($MaxAppointmentsPerParticipant) {$Body["appointment_group[max_appointments_per_participant]"] = $MaxAppointmentsPerParticipant}

	if ($AppointmentGroup[NewAppointments][X]) {$Body["appointment_group[new_appointments][X][]"] = $AppointmentGroup[NewAppointments][X]}

	if ($ParticipantVisibility) {$Body["appointment_group[participant_visibility]"] = $ParticipantVisibility}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Get a single appointment group 
.DESCRIPTION
   Returns information for a single appointment group
.EXAMPLE
   PS C:> Get-CanvasAppointmentGroups -Id $SomeIdObj -Include $SomeIncludeObj
#>
function Get-CanvasAppointmentGroups {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Array of additional information to include. See include[] argument of âList appointment groupsâ action.
		#âchild_eventsâ 
		#reservations of time slots time slots
		#âappointmentsâ 
		#will always be returned
		#âall_context_codesâ 
		#all context codes associated with this appointment group
		#Allowed values: child_events, appointments, all_context_codes 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/appointment_groups/{0}" -f $Id 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Update an appointment group 
.DESCRIPTION
   Update and return an appointment group. If new_appointments are specified, the response will return a new_appointments array (same format as appointments array, see âList appointment groupsâ action).
.EXAMPLE
   PS C:> Put-CanvasAppointmentGroups -Id $SomeIdObj -AppointmentGroup[ContextCodes] $SomeAppointmentGroup[ContextCodes]Obj -AppointmentGroup[SubContextCodes] $SomeAppointmentGroup[SubContextCodes]Obj -Title $SomeTitleObj -Description $SomeDescriptionObj -LocationName $SomeLocationNameObj -LocationAddress $SomeLocationAddressObj -Publish $SomePublishObj -ParticipantsPerAppointment $SomeParticipantsPerAppointmentObj -MinAppointmentsPerParticipant $SomeMinAppointmentsPerParticipantObj -MaxAppointmentsPerParticipant $SomeMaxAppointmentsPerParticipantObj -AppointmentGroup[NewAppointments][X] $SomeAppointmentGroup[NewAppointments][X]Obj -ParticipantVisibility $SomeParticipantVisibilityObj
#><#
function Put-CanvasAppointmentGroups {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Array of context codes (courses, e.g. course_1) this group should be linked to (1 or more). Users in the course(s) with appropriate permissions will be able to sign up for this appointment group.
        [Parameter(Mandatory=$true)]
        $AppointmentGroup[ContextCodes],

        # Array of sub context codes (course sections or a single group category) this group should be linked to. Used to limit the appointment group to particular sections. If a group category is specified, students will sign up in groups and the participant_type will be âGroupâ instead of âUserâ.
        [Parameter(Mandatory=$false)]
        $AppointmentGroup[SubContextCodes],

        # Short title for the appointment group.
        [Parameter(Mandatory=$false)]
        $Title,

        # Longer text description of the appointment group.
        [Parameter(Mandatory=$false)]
        $Description,

        # Location name of the appointment group.
        [Parameter(Mandatory=$false)]
        $LocationName,

        # Location address.
        [Parameter(Mandatory=$false)]
        $LocationAddress,

        # Indicates whether this appointment group should be published (i.e. made available for signup). Once published, an appointment group cannot be unpublished. Defaults to false.
        [Parameter(Mandatory=$false)]
        $Publish,

        # Maximum number of participants that may register for each time slot. Defaults to null (no limit).
        [Parameter(Mandatory=$false)]
        $ParticipantsPerAppointment,

        # Minimum number of time slots a user must register for. If not set, users do not need to sign up for any time slots.
        [Parameter(Mandatory=$false)]
        $MinAppointmentsPerParticipant,

        # Maximum number of time slots a user may register for.
        [Parameter(Mandatory=$false)]
        $MaxAppointmentsPerParticipant,

        # Nested array of start time/end time pairs indicating time slots for this appointment group. Refer to the example request.
        [Parameter(Mandatory=$false)]
        $AppointmentGroup[NewAppointments][X],

        # âprivateâ 
		#participants cannot see who has signed up for a particular time slot
		#âprotectedâ 
		#participants can see who has signed up. Defaults to âprivateâ.
		#Allowed values: private, protected 
        [Parameter(Mandatory=$false)]
        $ParticipantVisibility
	)

    $uri = "/api/v1/appointment_groups/{0}" -f $Id 

	$Body = @{}

	$Body["appointment_group[context_codes][]"] = $AppointmentGroup[ContextCodes]

	if ($AppointmentGroup[SubContextCodes]) {$Body["appointment_group[sub_context_codes][]"] = $AppointmentGroup[SubContextCodes]}

	if ($Title) {$Body["appointment_group[title]"] = $Title}

	if ($Description) {$Body["appointment_group[description]"] = $Description}

	if ($LocationName) {$Body["appointment_group[location_name]"] = $LocationName}

	if ($LocationAddress) {$Body["appointment_group[location_address]"] = $LocationAddress}

	if ($Publish) {$Body["appointment_group[publish]"] = $Publish}

	if ($ParticipantsPerAppointment) {$Body["appointment_group[participants_per_appointment]"] = $ParticipantsPerAppointment}

	if ($MinAppointmentsPerParticipant) {$Body["appointment_group[min_appointments_per_participant]"] = $MinAppointmentsPerParticipant}

	if ($MaxAppointmentsPerParticipant) {$Body["appointment_group[max_appointments_per_participant]"] = $MaxAppointmentsPerParticipant}

	if ($AppointmentGroup[NewAppointments][X]) {$Body["appointment_group[new_appointments][X][]"] = $AppointmentGroup[NewAppointments][X]}

	if ($ParticipantVisibility) {$Body["appointment_group[participant_visibility]"] = $ParticipantVisibility}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}
#>

<#
.Synopsis
   Delete an appointment group 
.DESCRIPTION
   Delete an appointment group (and associated time slots and reservations) and return the deleted group
.EXAMPLE
   PS C:> Delete-CanvasAppointmentGroups -Id $SomeIdObj -cancel_reason $Somecancel_reasonObj
#>
function Delete-CanvasAppointmentGroups {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Reason for deleting/canceling the appointment group.
        [Parameter(Mandatory=$false)]
        $cancel_reason
	)

    $uri = "/api/v1/appointment_groups/{0}" -f $Id 

	$Body = @{}

	if ($cancel_reason) {$Body["cancel_reason"] = $cancel_reason}

    return Get-CanvasApiResult $uri -Method DELETE -RequestParameters $Body
}


<#
.Synopsis
   List user participants 
.DESCRIPTION
   List users that are (or may be) participating in this appointment group. Refer to the Users API for the response fields. Returns no results for appointment groups with the âGroupâ participant_type.
.EXAMPLE
   PS C:> Get-CanvasAppointmentGroupsUsers -Id $SomeIdObj -registration_status $Someregistration_statusObj
#>
function Get-CanvasAppointmentGroupsUsers {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Limits results to the a given participation status, defaults to âallâ
		#Allowed values: all, registered, registered 
        [Parameter(Mandatory=$false)]
        $registration_status
	)

    $uri = "/api/v1/appointment_groups/{0}/users" -f $Id 

	$Body = @{}

	if ($registration_status) {$Body["registration_status"] = $registration_status}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List student group participants 
.DESCRIPTION
   List student groups that are (or may be) participating in this appointment group. Refer to the Groups API for the response fields. Returns no results for appointment groups with the âUserâ participant_type.
.EXAMPLE
   PS C:> Get-CanvasAppointmentGroupsGroups -Id $SomeIdObj -registration_status $Someregistration_statusObj
#>
function Get-CanvasAppointmentGroupsGroups {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Limits results to the a given participation status, defaults to âallâ
		#Allowed values: all, registered, registered 
        [Parameter(Mandatory=$false)]
        $registration_status
	)

    $uri = "/api/v1/appointment_groups/{0}/groups" -f $Id 

	$Body = @{}

	if ($registration_status) {$Body["registration_status"] = $registration_status}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get next appointment 
.DESCRIPTION
   Return the next appointment available to sign up for. The appointment is returned in a one-element array. If no future appointments are available, an empty array is returned.
.EXAMPLE
   PS C:> Get-CanvasAppointmentGroupsNextAppointment -AppointmentGroupIds $SomeAppointmentGroupIdsObj
#>
function Get-CanvasAppointmentGroupsNextAppointment {
[CmdletBinding()]

	Param
	(
        # List of ids of appointment groups to search.
        [Parameter(Mandatory=$false)]
        $AppointmentGroupIds
	)

    $uri = "/api/v1/appointment_groups/next_appointment" 

	$Body = @{}

	if ($AppointmentGroupIds) {$Body["appointment_group_ids[]"] = $AppointmentGroupIds}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List assignment groups 
.DESCRIPTION
   Returns the list of assignment groups for the current context. The returned groups are sorted by their position field.
.EXAMPLE
   PS C:> Get-CanvasCoursesAssignmentGroups -CourseId $SomeCourseIdObj -Include $SomeIncludeObj -ExcludeAssignmentSubmissionTypes $SomeExcludeAssignmentSubmissionTypesObj -override_assignment_dates $Someoverride_assignment_datesObj -grading_period_id $Somegrading_period_idObj -scope_assignments_to_student $Somescope_assignments_to_studentObj
#>
function Get-CanvasCoursesAssignmentGroups {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # Associations to include with the group. âdiscussion_topicâ, âall_datesâ âassignment_visibilityâ & âsubmissionâ are only valid are only valid if âassignmentsâ is also included. The âassignment_visibilityâ option additionally requires that the Differentiated Assignments course feature be turned on.
		#Allowed values: assignments, discussion_topic, all_dates, assignment_visibility, overrides, submission 
        [Parameter(Mandatory=$false)]
        $Include,

        # If âassignmentsâ are included, those with the specified submission types will be excluded from the assignment groups.
		#Allowed values: online_quiz, discussion_topic, wiki_page, external_tool 
        [Parameter(Mandatory=$false)]
        $ExcludeAssignmentSubmissionTypes,

        # Apply assignment overrides for each assignment, defaults to true.
        [Parameter(Mandatory=$false)]
        $override_assignment_dates,

        # The id of the grading period in which assignment groups are being requested (Requires the Multiple Grading Periods feature turned on.)
        [Parameter(Mandatory=$false)]
        $grading_period_id,

        # If true, all assignments returned will apply to the current user in the specified grading period. If assignments apply to other students in the specified grading period, but not the current user, they will not be returned. (Requires the grading_period_id argument and the Multiple Grading Periods feature turned on. In addition, the current user must be a student.)
        [Parameter(Mandatory=$false)]
        $scope_assignments_to_student
	)

    $uri = "/api/v1/courses/{0}/assignment_groups" -f $CourseId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

	if ($ExcludeAssignmentSubmissionTypes) {$Body["exclude_assignment_submission_types[]"] = $ExcludeAssignmentSubmissionTypes}

	if ($override_assignment_dates) {$Body["override_assignment_dates"] = $override_assignment_dates}

	if ($grading_period_id) {$Body["grading_period_id"] = $grading_period_id}

	if ($scope_assignments_to_student) {$Body["scope_assignments_to_student"] = $scope_assignments_to_student}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get an Assignment Group 
.DESCRIPTION
   Returns the assignment group with the given id.
.EXAMPLE
   PS C:> Get-CanvasCoursesAssignmentGroups -CourseId $SomeCourseIdObj -AssignmentGroupId $SomeAssignmentGroupIdObj -Include $SomeIncludeObj -override_assignment_dates $Someoverride_assignment_datesObj -grading_period_id $Somegrading_period_idObj
#>
function Get-CanvasCoursesAssignmentGroups {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentGroupId
        [Parameter(Mandatory=$true)]
        $AssignmentGroupId,

        # Associations to include with the group. âdiscussion_topicâ and âassignment_visibilityâ and âsubmissionâ are only valid if âassignmentsâ is also included. The âassignment_visibilityâ option additionally requires that the Differentiated Assignments course feature be turned on.
		#Allowed values: assignments, discussion_topic, assignment_visibility, submission 
        [Parameter(Mandatory=$false)]
        $Include,

        # Apply assignment overrides for each assignment, defaults to true.
        [Parameter(Mandatory=$false)]
        $override_assignment_dates,

        # The id of the grading period in which assignment groups are being requested (Requires the Multiple Grading Periods account feature turned on)
        [Parameter(Mandatory=$false)]
        $grading_period_id
	)

    $uri = "/api/v1/courses/{0}/assignment_groups/{1}" -f $CourseId, $AssignmentGroupId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

	if ($override_assignment_dates) {$Body["override_assignment_dates"] = $override_assignment_dates}

	if ($grading_period_id) {$Body["grading_period_id"] = $grading_period_id}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create an Assignment Group 
.DESCRIPTION
   Create a new assignment group for this course.
.EXAMPLE
   PS C:> Post-CanvasCoursesAssignmentGroups -CourseId $SomeCourseIdObj -name $SomenameObj -position $SomepositionObj -group_weight $Somegroup_weightObj -sis_source_id $Somesis_source_idObj -integration_data $Someintegration_dataObj -rules $SomerulesObj
#>
function Post-CanvasCoursesAssignmentGroups {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The assignment group's name
        [Parameter(Mandatory=$false)]
        $name,

        # The position of this assignment group in relation to the other assignment groups
        [Parameter(Mandatory=$false)]
        $position,

        # The percent of the total grade that this assignment group represents
        [Parameter(Mandatory=$false)]
        $group_weight,

        # The sis source id of the Assignment Group
        [Parameter(Mandatory=$false)]
        $sis_source_id,

        # The integration data of the Assignment Group
        [Parameter(Mandatory=$false)]
        $integration_data,

        # The grading rules that are applied within this assignment group See the Assignment Group object definition for format
        [Parameter(Mandatory=$false)]
        $rules
	)

    $uri = "/api/v1/courses/{0}/assignment_groups" -f $CourseId 

	$Body = @{}

	if ($name) {$Body["name"] = $name}

	if ($position) {$Body["position"] = $position}

	if ($group_weight) {$Body["group_weight"] = $group_weight}

	if ($sis_source_id) {$Body["sis_source_id"] = $sis_source_id}

	if ($integration_data) {$Body["integration_data"] = $integration_data}

	if ($rules) {$Body["rules"] = $rules}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Edit an Assignment Group 
.DESCRIPTION
   Modify an existing Assignment Group. Accepts the same parameters as Assignment Group creation
.EXAMPLE
   PS C:> Put-CanvasCoursesAssignmentGroups -CourseId $SomeCourseIdObj -AssignmentGroupId $SomeAssignmentGroupIdObj
#>
function Put-CanvasCoursesAssignmentGroups {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentGroupId
        [Parameter(Mandatory=$true)]
        $AssignmentGroupId
	)

    $uri = "/api/v1/courses/{0}/assignment_groups/{1}" -f $CourseId, $AssignmentGroupId 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Destroy an Assignment Group 
.DESCRIPTION
   Deletes the assignment group with the given id.
.EXAMPLE
   PS C:> Delete-CanvasCoursesAssignmentGroups -CourseId $SomeCourseIdObj -AssignmentGroupId $SomeAssignmentGroupIdObj -move_assignments_to $Somemove_assignments_toObj
#>
function Delete-CanvasCoursesAssignmentGroups {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentGroupId
        [Parameter(Mandatory=$true)]
        $AssignmentGroupId,

        # The ID of an active Assignment Group to which the assignments that are currently assigned to the destroyed Assignment Group will be assigned. NOTE: If this argument is not provided, any assignments in this Assignment Group will be deleted.
        [Parameter(Mandatory=$false)]
        $move_assignments_to
	)

    $uri = "/api/v1/courses/{0}/assignment_groups/{1}" -f $CourseId, $AssignmentGroupId 

	$Body = @{}

	if ($move_assignments_to) {$Body["move_assignments_to"] = $move_assignments_to}

    return Get-CanvasApiResult $uri -Method DELETE -RequestParameters $Body
}


<#
.Synopsis
   Delete an assignment 
.DESCRIPTION
   Delete the given assignment.
.EXAMPLE
   PS C:> Delete-CanvasCoursesAssignments -CourseId $SomeCourseIdObj -Id $SomeIdObj
#>
function Delete-CanvasCoursesAssignments {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}" -f $CourseId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   List assignments 
.DESCRIPTION
   Returns the list of assignments for the current context.
.EXAMPLE
   PS C:> Get-CanvasCoursesAssignments -CourseId $SomeCourseIdObj -Include $SomeIncludeObj -search_term $Somesearch_termObj -override_assignment_dates $Someoverride_assignment_datesObj -needs_grading_count_by_section $Someneeds_grading_count_by_sectionObj -bucket $SomebucketObj -AssignmentIds $SomeAssignmentIdsObj
#>
function Get-CanvasCoursesAssignments {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # Associations to include with the assignment. The âassignment_visibilityâ option requires that the Differentiated Assignments course feature be turned on. If âobserved_usersâ is passed, submissions for observed users will also be included as an array.
		#Allowed values: submission, assignment_visibility, all_dates, overrides, observed_users 
        [Parameter(Mandatory=$false)]
        $Include,

        # The partial title of the assignments to match and return.
        [Parameter(Mandatory=$false)]
        $search_term,

        # Apply assignment overrides for each assignment, defaults to true.
        [Parameter(Mandatory=$false)]
        $override_assignment_dates,

        # Split up âneeds_grading_countâ by sections into the âneeds_grading_count_by_sectionâ key, defaults to false
        [Parameter(Mandatory=$false)]
        $needs_grading_count_by_section,

        # If included, only return certain assignments depending on due date and submission status.
		#Allowed values: past, overdue, undated, ungraded, unsubmitted, upcoming, future 
        [Parameter(Mandatory=$false)]
        $bucket,

        # if set, return only assignments specified
        [Parameter(Mandatory=$false)]
        $AssignmentIds
	)

    $uri = "/api/v1/courses/{0}/assignments" -f $CourseId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

	if ($search_term) {$Body["search_term"] = $search_term}

	if ($override_assignment_dates) {$Body["override_assignment_dates"] = $override_assignment_dates}

	if ($needs_grading_count_by_section) {$Body["needs_grading_count_by_section"] = $needs_grading_count_by_section}

	if ($bucket) {$Body["bucket"] = $bucket}

	if ($AssignmentIds) {$Body["assignment_ids[]"] = $AssignmentIds}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List assignments for user 
.DESCRIPTION
   Returns the list of assignments for the specified user if the current user has rights to view. See List assignments for valid arguments.
.EXAMPLE
   PS C:> Get-CanvasUsersCoursesAssignments -UserId $SomeUserIdObj -CourseId $SomeCourseIdObj
#>
function Get-CanvasUsersCoursesAssignments {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/users/{0}/courses/{1}/assignments" -f $UserId, $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get a single assignment 
.DESCRIPTION
   Returns the assignment with the given id.
.EXAMPLE
   PS C:> Get-CanvasCoursesAssignments -CourseId $SomeCourseIdObj -Id $SomeIdObj -Include $SomeIncludeObj -override_assignment_dates $Someoverride_assignment_datesObj -needs_grading_count_by_section $Someneeds_grading_count_by_sectionObj -all_dates $Someall_datesObj
#>
function Get-CanvasCoursesAssignments {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Associations to include with the assignment. The âassignment_visibilityâ option requires that the Differentiated Assignments course feature be turned on. If
		#Allowed values: submission, assignment_visibility, overrides, observed_users 
        [Parameter(Mandatory=$false)]
        $Include,

        # Apply assignment overrides to the assignment, defaults to true.
        [Parameter(Mandatory=$false)]
        $override_assignment_dates,

        # Split up âneeds_grading_countâ by sections into the âneeds_grading_count_by_sectionâ key, defaults to false
        [Parameter(Mandatory=$false)]
        $needs_grading_count_by_section,

        # All dates associated with the assignment, if applicable
        [Parameter(Mandatory=$false)]
        $all_dates
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}" -f $CourseId, $Id 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

	if ($override_assignment_dates) {$Body["override_assignment_dates"] = $override_assignment_dates}

	if ($needs_grading_count_by_section) {$Body["needs_grading_count_by_section"] = $needs_grading_count_by_section}

	if ($all_dates) {$Body["all_dates"] = $all_dates}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create an assignment 
.DESCRIPTION
   Create a new assignment for this course. The assignment is created in the active state.
.EXAMPLE
   PS C:> Post-CanvasCoursesAssignments -CourseId $SomeCourseIdObj -Name $SomeNameObj -Position $SomePositionObj -Assignment[SubmissionTypes] $SomeAssignment[SubmissionTypes]Obj -Assignment[AllowedExtensions] $SomeAssignment[AllowedExtensions]Obj -TurnitinEnabled $SomeTurnitinEnabledObj -VericiteEnabled $SomeVericiteEnabledObj -TurnitinSettings $SomeTurnitinSettingsObj -IntegrationData $SomeIntegrationDataObj -IntegrationId $SomeIntegrationIdObj -PeerReviews $SomePeerReviewsObj -AutomaticPeerReviews $SomeAutomaticPeerReviewsObj -NotifyOfUpdate $SomeNotifyOfUpdateObj -GroupCategoryId $SomeGroupCategoryIdObj -GradeGroupStudentsIndividually $SomeGradeGroupStudentsIndividuallyObj -ExternalToolTagAttributes $SomeExternalToolTagAttributesObj -PointsPossible $SomePointsPossibleObj -GradingType $SomeGradingTypeObj -DueAt $SomeDueAtObj -LockAt $SomeLockAtObj -UnlockAt $SomeUnlockAtObj -Description $SomeDescriptionObj -AssignmentGroupId $SomeAssignmentGroupIdObj -Muted $SomeMutedObj -Assignment[AssignmentOverrides] $SomeAssignment[AssignmentOverrides]Obj -OnlyVisibleToOverrides $SomeOnlyVisibleToOverridesObj -Published $SomePublishedObj -GradingStandardId $SomeGradingStandardIdObj -OmitFromFinalGrade $SomeOmitFromFinalGradeObj
#><#
function Post-CanvasCoursesAssignments {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The assignment name.
        [Parameter(Mandatory=$true)]
        $Name,

        # The position of this assignment in the group when displaying assignment lists.
        [Parameter(Mandatory=$false)]
        $Position,

        # List of supported submission types for the assignment. Unless the assignment is allowing online submissions, the array should only have one element.
		#If not allowing online submissions, your options are:
		#"online_quiz"
		#"none"
		#"on_paper"
		#"online_quiz"
		#"discussion_topic"
		#"external_tool"
		#If you are allowing online submissions, you can have one or many allowed submission types:
		#"online_upload"
		#"online_text_entry"
		#"online_url"
		#"media_recording" (Only valid when the Kaltura plugin is enabled)Allowed values: online_quiz, none, on_paper, online_quiz, discussion_topic, external_tool, online_upload, online_text_entry, online_url, media_recording 
        [Parameter(Mandatory=$false)]
        $Assignment[SubmissionTypes],

        # Allowed extensions if submission_types includes âonline_uploadâ
		#Example:
		#allowed_extensions: ["docx","ppt"]
        [Parameter(Mandatory=$false)]
        $Assignment[AllowedExtensions],

        # Only applies when the Turnitin plugin is enabled for a course and the submission_types array includes âonline_uploadâ. Toggles Turnitin submissions for the assignment. Will be ignored if Turnitin is not available for the course.
        [Parameter(Mandatory=$false)]
        $TurnitinEnabled,

        # Only applies when the VeriCite plugin is enabled for a course and the submission_types array includes âonline_uploadâ. Toggles VeriCite submissions for the assignment. Will be ignored if VeriCite is not available for the course.
        [Parameter(Mandatory=$false)]
        $VericiteEnabled,

        # Settings to send along to turnitin. See Assignment object definition for format.
        [Parameter(Mandatory=$false)]
        $TurnitinSettings,

        # Data related to third party integrations, JSON string required.
        [Parameter(Mandatory=$false)]
        $IntegrationData,

        # Unique ID from third party integrations
        [Parameter(Mandatory=$false)]
        $IntegrationId,

        # If submission_types does not include external_tool,discussion_topic, online_quiz, or on_paper, determines whether or not peer reviews will be turned on for the assignment.
        [Parameter(Mandatory=$false)]
        $PeerReviews,

        # Whether peer reviews will be assigned automatically by Canvas or if teachers must manually assign peer reviews. Does not apply if peer reviews are not enabled.
        [Parameter(Mandatory=$false)]
        $AutomaticPeerReviews,

        # If true, Canvas will send a notification to students in the class notifying them that the content has changed.
        [Parameter(Mandatory=$false)]
        $NotifyOfUpdate,

        # If present, the assignment will become a group assignment assigned to the group.
        [Parameter(Mandatory=$false)]
        $GroupCategoryId,

        # If this is a group assignment, teachers have the options to grade students individually. If false, Canvas will apply the assignment's score to each member of the group. If true, the teacher can manually assign scores to each member of the group.
        [Parameter(Mandatory=$false)]
        $GradeGroupStudentsIndividually,

        # Hash of external tool parameters if submission_types is [âexternal_toolâ]. See Assignment object definition for format.
        [Parameter(Mandatory=$false)]
        $ExternalToolTagAttributes,

        # The maximum points possible on the assignment.
        [Parameter(Mandatory=$false)]
        $PointsPossible,

        # The strategy used for grading the assignment. The assignment defaults to âpointsâ if this field is omitted.
		#Allowed values: pass_fail, percent, letter_grade, gpa_scale, points 
        [Parameter(Mandatory=$false)]
        $GradingType,

        # The day/time the assignment is due. Accepts times in ISO 8601 format, e.g. 2014-10-21T18:48:00Z.
        [Parameter(Mandatory=$false)]
        $DueAt,

        # The day/time the assignment is locked after. Accepts times in ISO 8601 format, e.g. 2014-10-21T18:48:00Z.
        [Parameter(Mandatory=$false)]
        $LockAt,

        # The day/time the assignment is unlocked. Accepts times in ISO 8601 format, e.g. 2014-10-21T18:48:00Z.
        [Parameter(Mandatory=$false)]
        $UnlockAt,

        # The assignment's description, supports HTML.
        [Parameter(Mandatory=$false)]
        $Description,

        # The assignment group id to put the assignment in. Defaults to the top assignment group in the course.
        [Parameter(Mandatory=$false)]
        $AssignmentGroupId,

        # Whether this assignment is muted. A muted assignment does not send change notifications and hides grades from students. Defaults to false.
        [Parameter(Mandatory=$false)]
        $Muted,

        # List of overrides for the assignment. NOTE: The assignment overrides feature is in beta.
        [Parameter(Mandatory=$false)]
        $Assignment[AssignmentOverrides],

        # Whether this assignment is only visible to overrides (Only useful if 'differentiated assignments' account setting is on)
        [Parameter(Mandatory=$false)]
        $OnlyVisibleToOverrides,

        # Whether this assignment is published. (Only useful if 'draft state' account setting is on) Unpublished assignments are not visible to students.
        [Parameter(Mandatory=$false)]
        $Published,

        # The grading standard id to set for the course. If no value is provided for this argument the current grading_standard will be un-set from this course. This will update the grading_type for the course to 'letter_grade' unless it is already 'gpa_scale'.
        [Parameter(Mandatory=$false)]
        $GradingStandardId,

        # Whether this assignment is counted towards a student's final grade.
        [Parameter(Mandatory=$false)]
        $OmitFromFinalGrade
	)

    $uri = "/api/v1/courses/{0}/assignments" -f $CourseId 

	$Body = @{}

	$Body["assignment[name]"] = $Name

	if ($Position) {$Body["assignment[position]"] = $Position}

	if ($Assignment[SubmissionTypes]) {$Body["assignment[submission_types][]"] = $Assignment[SubmissionTypes]}

	if ($Assignment[AllowedExtensions]) {$Body["assignment[allowed_extensions][]"] = $Assignment[AllowedExtensions]}

	if ($TurnitinEnabled) {$Body["assignment[turnitin_enabled]"] = $TurnitinEnabled}

	if ($VericiteEnabled) {$Body["assignment[vericite_enabled]"] = $VericiteEnabled}

	if ($TurnitinSettings) {$Body["assignment[turnitin_settings]"] = $TurnitinSettings}

	if ($IntegrationData) {$Body["assignment[integration_data]"] = $IntegrationData}

	if ($IntegrationId) {$Body["assignment[integration_id]"] = $IntegrationId}

	if ($PeerReviews) {$Body["assignment[peer_reviews]"] = $PeerReviews}

	if ($AutomaticPeerReviews) {$Body["assignment[automatic_peer_reviews]"] = $AutomaticPeerReviews}

	if ($NotifyOfUpdate) {$Body["assignment[notify_of_update]"] = $NotifyOfUpdate}

	if ($GroupCategoryId) {$Body["assignment[group_category_id]"] = $GroupCategoryId}

	if ($GradeGroupStudentsIndividually) {$Body["assignment[grade_group_students_individually]"] = $GradeGroupStudentsIndividually}

	if ($ExternalToolTagAttributes) {$Body["assignment[external_tool_tag_attributes]"] = $ExternalToolTagAttributes}

	if ($PointsPossible) {$Body["assignment[points_possible]"] = $PointsPossible}

	if ($GradingType) {$Body["assignment[grading_type]"] = $GradingType}

	if ($DueAt) {$Body["assignment[due_at]"] = $DueAt}

	if ($LockAt) {$Body["assignment[lock_at]"] = $LockAt}

	if ($UnlockAt) {$Body["assignment[unlock_at]"] = $UnlockAt}

	if ($Description) {$Body["assignment[description]"] = $Description}

	if ($AssignmentGroupId) {$Body["assignment[assignment_group_id]"] = $AssignmentGroupId}

	if ($Muted) {$Body["assignment[muted]"] = $Muted}

	if ($Assignment[AssignmentOverrides]) {$Body["assignment[assignment_overrides][]"] = $Assignment[AssignmentOverrides]}

	if ($OnlyVisibleToOverrides) {$Body["assignment[only_visible_to_overrides]"] = $OnlyVisibleToOverrides}

	if ($Published) {$Body["assignment[published]"] = $Published}

	if ($GradingStandardId) {$Body["assignment[grading_standard_id]"] = $GradingStandardId}

	if ($OmitFromFinalGrade) {$Body["assignment[omit_from_final_grade]"] = $OmitFromFinalGrade}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Edit an assignment 
.DESCRIPTION
   Modify an existing assignment. If the assignment [assignment_overrides] key is absent, any existing overrides are kept as is. If the assignment [assignment_overrides] key is present, existing overrides are updated or deleted (and new ones created, as necessary) to match the provided list. NOTE: The assignment overrides feature is in beta.
.EXAMPLE
   PS C:> Put-CanvasCoursesAssignments -CourseId $SomeCourseIdObj -Id $SomeIdObj -Name $SomeNameObj -Position $SomePositionObj -Assignment[SubmissionTypes] $SomeAssignment[SubmissionTypes]Obj -Assignment[AllowedExtensions] $SomeAssignment[AllowedExtensions]Obj -TurnitinEnabled $SomeTurnitinEnabledObj -VericiteEnabled $SomeVericiteEnabledObj -TurnitinSettings $SomeTurnitinSettingsObj -IntegrationData $SomeIntegrationDataObj -IntegrationId $SomeIntegrationIdObj -PeerReviews $SomePeerReviewsObj -AutomaticPeerReviews $SomeAutomaticPeerReviewsObj -NotifyOfUpdate $SomeNotifyOfUpdateObj -GroupCategoryId $SomeGroupCategoryIdObj -GradeGroupStudentsIndividually $SomeGradeGroupStudentsIndividuallyObj -ExternalToolTagAttributes $SomeExternalToolTagAttributesObj -PointsPossible $SomePointsPossibleObj -GradingType $SomeGradingTypeObj -DueAt $SomeDueAtObj -LockAt $SomeLockAtObj -UnlockAt $SomeUnlockAtObj -Description $SomeDescriptionObj -AssignmentGroupId $SomeAssignmentGroupIdObj -Muted $SomeMutedObj -Assignment[AssignmentOverrides] $SomeAssignment[AssignmentOverrides]Obj -OnlyVisibleToOverrides $SomeOnlyVisibleToOverridesObj -Published $SomePublishedObj -GradingStandardId $SomeGradingStandardIdObj -OmitFromFinalGrade $SomeOmitFromFinalGradeObj
#><#
function Put-CanvasCoursesAssignments {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The assignment name.
        [Parameter(Mandatory=$false)]
        $Name,

        # The position of this assignment in the group when displaying assignment lists.
        [Parameter(Mandatory=$false)]
        $Position,

        # List of supported submission types for the assignment. Unless the assignment is allowing online submissions, the array should only have one element.
		#If not allowing online submissions, your options are:
		#"online_quiz"
		#"none"
		#"on_paper"
		#"online_quiz"
		#"discussion_topic"
		#"external_tool"
		#If you are allowing online submissions, you can have one or many allowed submission types:
		#"online_upload"
		#"online_text_entry"
		#"online_url"
		#"media_recording" (Only valid when the Kaltura plugin is enabled)Allowed values: online_quiz, none, on_paper, online_quiz, discussion_topic, external_tool, online_upload, online_text_entry, online_url, media_recording 
        [Parameter(Mandatory=$false)]
        $Assignment[SubmissionTypes],

        # Allowed extensions if submission_types includes âonline_uploadâ
		#Example:
		#allowed_extensions: ["docx","ppt"]
        [Parameter(Mandatory=$false)]
        $Assignment[AllowedExtensions],

        # Only applies when the Turnitin plugin is enabled for a course and the submission_types array includes âonline_uploadâ. Toggles Turnitin submissions for the assignment. Will be ignored if Turnitin is not available for the course.
        [Parameter(Mandatory=$false)]
        $TurnitinEnabled,

        # Only applies when the VeriCite plugin is enabled for a course and the submission_types array includes âonline_uploadâ. Toggles VeriCite submissions for the assignment. Will be ignored if VeriCite is not available for the course.
        [Parameter(Mandatory=$false)]
        $VericiteEnabled,

        # Settings to send along to turnitin. See Assignment object definition for format.
        [Parameter(Mandatory=$false)]
        $TurnitinSettings,

        # Data related to third party integrations, JSON string required.
        [Parameter(Mandatory=$false)]
        $IntegrationData,

        # Unique ID from third party integrations
        [Parameter(Mandatory=$false)]
        $IntegrationId,

        # If submission_types does not include external_tool,discussion_topic, online_quiz, or on_paper, determines whether or not peer reviews will be turned on for the assignment.
        [Parameter(Mandatory=$false)]
        $PeerReviews,

        # Whether peer reviews will be assigned automatically by Canvas or if teachers must manually assign peer reviews. Does not apply if peer reviews are not enabled.
        [Parameter(Mandatory=$false)]
        $AutomaticPeerReviews,

        # If true, Canvas will send a notification to students in the class notifying them that the content has changed.
        [Parameter(Mandatory=$false)]
        $NotifyOfUpdate,

        # If present, the assignment will become a group assignment assigned to the group.
        [Parameter(Mandatory=$false)]
        $GroupCategoryId,

        # If this is a group assignment, teachers have the options to grade students individually. If false, Canvas will apply the assignment's score to each member of the group. If true, the teacher can manually assign scores to each member of the group.
        [Parameter(Mandatory=$false)]
        $GradeGroupStudentsIndividually,

        # Hash of external tool parameters if submission_types is [âexternal_toolâ]. See Assignment object definition for format.
        [Parameter(Mandatory=$false)]
        $ExternalToolTagAttributes,

        # The maximum points possible on the assignment.
        [Parameter(Mandatory=$false)]
        $PointsPossible,

        # The strategy used for grading the assignment. The assignment defaults to âpointsâ if this field is omitted.
		#Allowed values: pass_fail, percent, letter_grade, gpa_scale, points 
        [Parameter(Mandatory=$false)]
        $GradingType,

        # The day/time the assignment is due. Accepts times in ISO 8601 format, e.g. 2014-10-21T18:48:00Z.
        [Parameter(Mandatory=$false)]
        $DueAt,

        # The day/time the assignment is locked after. Accepts times in ISO 8601 format, e.g. 2014-10-21T18:48:00Z.
        [Parameter(Mandatory=$false)]
        $LockAt,

        # The day/time the assignment is unlocked. Accepts times in ISO 8601 format, e.g. 2014-10-21T18:48:00Z.
        [Parameter(Mandatory=$false)]
        $UnlockAt,

        # The assignment's description, supports HTML.
        [Parameter(Mandatory=$false)]
        $Description,

        # The assignment group id to put the assignment in. Defaults to the top assignment group in the course.
        [Parameter(Mandatory=$false)]
        $AssignmentGroupId,

        # Whether this assignment is muted. A muted assignment does not send change notifications and hides grades from students. Defaults to false.
        [Parameter(Mandatory=$false)]
        $Muted,

        # List of overrides for the assignment. NOTE: The assignment overrides feature is in beta.
        [Parameter(Mandatory=$false)]
        $Assignment[AssignmentOverrides],

        # Whether this assignment is only visible to overrides (Only useful if 'differentiated assignments' account setting is on)
        [Parameter(Mandatory=$false)]
        $OnlyVisibleToOverrides,

        # Whether this assignment is published. (Only useful if 'draft state' account setting is on) Unpublished assignments are not visible to students.
        [Parameter(Mandatory=$false)]
        $Published,

        # The grading standard id to set for the course. If no value is provided for this argument the current grading_standard will be un-set from this course. This will update the grading_type for the course to 'letter_grade' unless it is already 'gpa_scale'.
        [Parameter(Mandatory=$false)]
        $GradingStandardId,

        # Whether this assignment is counted towards a student's final grade.
        [Parameter(Mandatory=$false)]
        $OmitFromFinalGrade
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}" -f $CourseId, $Id 

	$Body = @{}

	if ($Name) {$Body["assignment[name]"] = $Name}

	if ($Position) {$Body["assignment[position]"] = $Position}

	if ($Assignment[SubmissionTypes]) {$Body["assignment[submission_types][]"] = $Assignment[SubmissionTypes]}

	if ($Assignment[AllowedExtensions]) {$Body["assignment[allowed_extensions][]"] = $Assignment[AllowedExtensions]}

	if ($TurnitinEnabled) {$Body["assignment[turnitin_enabled]"] = $TurnitinEnabled}

	if ($VericiteEnabled) {$Body["assignment[vericite_enabled]"] = $VericiteEnabled}

	if ($TurnitinSettings) {$Body["assignment[turnitin_settings]"] = $TurnitinSettings}

	if ($IntegrationData) {$Body["assignment[integration_data]"] = $IntegrationData}

	if ($IntegrationId) {$Body["assignment[integration_id]"] = $IntegrationId}

	if ($PeerReviews) {$Body["assignment[peer_reviews]"] = $PeerReviews}

	if ($AutomaticPeerReviews) {$Body["assignment[automatic_peer_reviews]"] = $AutomaticPeerReviews}

	if ($NotifyOfUpdate) {$Body["assignment[notify_of_update]"] = $NotifyOfUpdate}

	if ($GroupCategoryId) {$Body["assignment[group_category_id]"] = $GroupCategoryId}

	if ($GradeGroupStudentsIndividually) {$Body["assignment[grade_group_students_individually]"] = $GradeGroupStudentsIndividually}

	if ($ExternalToolTagAttributes) {$Body["assignment[external_tool_tag_attributes]"] = $ExternalToolTagAttributes}

	if ($PointsPossible) {$Body["assignment[points_possible]"] = $PointsPossible}

	if ($GradingType) {$Body["assignment[grading_type]"] = $GradingType}

	if ($DueAt) {$Body["assignment[due_at]"] = $DueAt}

	if ($LockAt) {$Body["assignment[lock_at]"] = $LockAt}

	if ($UnlockAt) {$Body["assignment[unlock_at]"] = $UnlockAt}

	if ($Description) {$Body["assignment[description]"] = $Description}

	if ($AssignmentGroupId) {$Body["assignment[assignment_group_id]"] = $AssignmentGroupId}

	if ($Muted) {$Body["assignment[muted]"] = $Muted}

	if ($Assignment[AssignmentOverrides]) {$Body["assignment[assignment_overrides][]"] = $Assignment[AssignmentOverrides]}

	if ($OnlyVisibleToOverrides) {$Body["assignment[only_visible_to_overrides]"] = $OnlyVisibleToOverrides}

	if ($Published) {$Body["assignment[published]"] = $Published}

	if ($GradingStandardId) {$Body["assignment[grading_standard_id]"] = $GradingStandardId}

	if ($OmitFromFinalGrade) {$Body["assignment[omit_from_final_grade]"] = $OmitFromFinalGrade}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}
#>

<#
.Synopsis
   List assignment overrides 
.DESCRIPTION
   Returns the list of overrides for this assignment that target sections/groups/students visible to the current user.
.EXAMPLE
   PS C:> Get-CanvasCoursesAssignmentsOverrides -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj
#>
function Get-CanvasCoursesAssignmentsOverrides {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/overrides" -f $CourseId, $AssignmentId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get a single assignment override 
.DESCRIPTION
   Returns details of the the override with the given id.
.EXAMPLE
   PS C:> Get-CanvasCoursesAssignmentsOverrides -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -Id $SomeIdObj
#>
function Get-CanvasCoursesAssignmentsOverrides {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/overrides/{2}" -f $CourseId, $AssignmentId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Redirect to the assignment override for a group 
.DESCRIPTION
   Responds with a redirect to the override for the given group, if any (404 otherwise).
.EXAMPLE
   PS C:> Get-CanvasGroupsAssignmentsOverride -GroupId $SomeGroupIdObj -AssignmentId $SomeAssignmentIdObj
#>
function Get-CanvasGroupsAssignmentsOverride {
[CmdletBinding()]

	Param
	(
        # The GroupId
        [Parameter(Mandatory=$true)]
        $GroupId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId
	)

    $uri = "/api/v1/groups/{0}/assignments/{1}/override" -f $GroupId, $AssignmentId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Redirect to the assignment override for a section 
.DESCRIPTION
   Responds with a redirect to the override for the given section, if any (404 otherwise).
.EXAMPLE
   PS C:> Get-CanvasSectionsAssignmentsOverride -CourseSectionId $SomeCourseSectionIdObj -AssignmentId $SomeAssignmentIdObj
#>
function Get-CanvasSectionsAssignmentsOverride {
[CmdletBinding()]

	Param
	(
        # The CourseSectionId
        [Parameter(Mandatory=$true)]
        $CourseSectionId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId
	)

    $uri = "/api/v1/sections/{0}/assignments/{1}/override" -f $CourseSectionId, $AssignmentId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create an assignment override 
.DESCRIPTION
   One of student_ids, group_id, or course_section_id must be present. At most one should be present; if multiple are present only the most specific (student_ids first, then group_id, then course_section_id) is used and any others are ignored.
.EXAMPLE
   PS C:> Post-CanvasCoursesAssignmentsOverrides -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -AssignmentOverride[StudentIds] $SomeAssignmentOverride[StudentIds]Obj -Title $SomeTitleObj -GroupId $SomeGroupIdObj -CourseSectionId $SomeCourseSectionIdObj -DueAt $SomeDueAtObj -UnlockAt $SomeUnlockAtObj -LockAt $SomeLockAtObj
#><#
function Post-CanvasCoursesAssignmentsOverrides {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The IDs of the override's target students. If present, the IDs must each identify a user with an active student enrollment in the course that is not already targetted by a different adhoc override.
        [Parameter(Mandatory=$false)]
        $AssignmentOverride[StudentIds],

        # The title of the adhoc assignment override. Required if student_ids is present, ignored otherwise (the title is set to the name of the targetted group or section instead).
        [Parameter(Mandatory=$false)]
        $Title,

        # The ID of the override's target group. If present, the following conditions must be met for the override to be successful:
		#the assignment MUST be a group assignment (a group_category_id is assigned to it)
		#the ID must identify an active group in the group set the assignment is in
		#the ID must not be targetted by a different override
		#See Appendix: Group assignments for more info.
        [Parameter(Mandatory=$false)]
        $GroupId,

        # The ID of the override's target section. If present, must identify an active section of the assignment's course not already targetted by a different override.
        [Parameter(Mandatory=$false)]
        $CourseSectionId,

        # The day/time the overridden assignment is due. Accepts times in ISO 8601 format, e.g. 2014-10-21T18:48:00Z. If absent, this override will not affect due date. May be present but null to indicate the override removes any previous due date.
        [Parameter(Mandatory=$false)]
        $DueAt,

        # The day/time the overridden assignment becomes unlocked. Accepts times in ISO 8601 format, e.g. 2014-10-21T18:48:00Z. If absent, this override will not affect the unlock date. May be present but null to indicate the override removes any previous unlock date.
        [Parameter(Mandatory=$false)]
        $UnlockAt,

        # The day/time the overridden assignment becomes locked. Accepts times in ISO 8601 format, e.g. 2014-10-21T18:48:00Z. If absent, this override will not affect the lock date. May be present but null to indicate the override removes any previous lock date.
        [Parameter(Mandatory=$false)]
        $LockAt
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/overrides" -f $CourseId, $AssignmentId 

	$Body = @{}

	if ($AssignmentOverride[StudentIds]) {$Body["assignment_override[student_ids][]"] = $AssignmentOverride[StudentIds]}

	if ($Title) {$Body["assignment_override[title]"] = $Title}

	if ($GroupId) {$Body["assignment_override[group_id]"] = $GroupId}

	if ($CourseSectionId) {$Body["assignment_override[course_section_id]"] = $CourseSectionId}

	if ($DueAt) {$Body["assignment_override[due_at]"] = $DueAt}

	if ($UnlockAt) {$Body["assignment_override[unlock_at]"] = $UnlockAt}

	if ($LockAt) {$Body["assignment_override[lock_at]"] = $LockAt}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Update an assignment override 
.DESCRIPTION
   All current overridden values must be supplied if they are to be retained; e.g. if due_at was overridden, but this PUT omits a value for due_at, due_at will no longer be overridden. If the override is adhoc and student_ids is not supplied, the target override set is unchanged. Target override sets cannot be changed for group or section overrides.
.EXAMPLE
   PS C:> Put-CanvasCoursesAssignmentsOverrides -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -Id $SomeIdObj -AssignmentOverride[StudentIds] $SomeAssignmentOverride[StudentIds]Obj -Title $SomeTitleObj -DueAt $SomeDueAtObj -UnlockAt $SomeUnlockAtObj -LockAt $SomeLockAtObj
#><#
function Put-CanvasCoursesAssignmentsOverrides {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The IDs of the override's target students. If present, the IDs must each identify a user with an active student enrollment in the course that is not already targetted by a different adhoc override. Ignored unless the override being updated is adhoc.
        [Parameter(Mandatory=$false)]
        $AssignmentOverride[StudentIds],

        # The title of an adhoc assignment override. Ignored unless the override being updated is adhoc.
        [Parameter(Mandatory=$false)]
        $Title,

        # The day/time the overridden assignment is due. Accepts times in ISO 8601 format, e.g. 2014-10-21T18:48:00Z. If absent, this override will not affect due date. May be present but null to indicate the override removes any previous due date.
        [Parameter(Mandatory=$false)]
        $DueAt,

        # The day/time the overridden assignment becomes unlocked. Accepts times in ISO 8601 format, e.g. 2014-10-21T18:48:00Z. If absent, this override will not affect the unlock date. May be present but null to indicate the override removes any previous unlock date.
        [Parameter(Mandatory=$false)]
        $UnlockAt,

        # The day/time the overridden assignment becomes locked. Accepts times in ISO 8601 format, e.g. 2014-10-21T18:48:00Z. If absent, this override will not affect the lock date. May be present but null to indicate the override removes any previous lock date.
        [Parameter(Mandatory=$false)]
        $LockAt
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/overrides/{2}" -f $CourseId, $AssignmentId, $Id 

	$Body = @{}

	if ($AssignmentOverride[StudentIds]) {$Body["assignment_override[student_ids][]"] = $AssignmentOverride[StudentIds]}

	if ($Title) {$Body["assignment_override[title]"] = $Title}

	if ($DueAt) {$Body["assignment_override[due_at]"] = $DueAt}

	if ($UnlockAt) {$Body["assignment_override[unlock_at]"] = $UnlockAt}

	if ($LockAt) {$Body["assignment_override[lock_at]"] = $LockAt}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}
#>

<#
.Synopsis
   Delete an assignment override 
.DESCRIPTION
   Deletes an override and returns its former details.
.EXAMPLE
   PS C:> Delete-CanvasCoursesAssignmentsOverrides -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -Id $SomeIdObj
#>
function Delete-CanvasCoursesAssignmentsOverrides {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/overrides/{2}" -f $CourseId, $AssignmentId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Batch retrieve overrides in a course 
.DESCRIPTION
   Returns a list of specified overrides in this course, providing they target sections/groups/students visible to the current user. Returns null elements in the list for requests that were not found.
.EXAMPLE
   PS C:> Get-CanvasCoursesAssignmentsOverrides -CourseId $SomeCourseIdObj -AssignmentOverrides[Id] $SomeAssignmentOverrides[Id]Obj -AssignmentOverrides[AssignmentId] $SomeAssignmentOverrides[AssignmentId]Obj
#><#
function Get-CanvasCoursesAssignmentsOverrides {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # Ids of overrides to retrieve
        [Parameter(Mandatory=$true)]
        $AssignmentOverrides[Id],

        # Ids of assignments for each override
        [Parameter(Mandatory=$true)]
        $AssignmentOverrides[AssignmentId]
	)

    $uri = "/api/v1/courses/{0}/assignments/overrides" -f $CourseId 

	$Body = @{}

	$Body["assignment_overrides[][id]"] = $AssignmentOverrides[Id]

	$Body["assignment_overrides[][assignment_id]"] = $AssignmentOverrides[AssignmentId]

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}
#>

<#
.Synopsis
   Batch create overrides in a course 
.DESCRIPTION
   Creates the specified overrides for each assignment. Handles creation in a transaction, so all records are created or none are. One of student_ids, group_id, or course_section_id must be present. At most one should be present; if multiple are present only the most specific (student_ids first, then group_id, then course_section_id) is used and any others are ignored. Errors are reported in an errors attribute, an array of errors corresponding to inputs. Global errors will be reported as a single element errors array
.EXAMPLE
   PS C:> Post-CanvasCoursesAssignmentsOverrides -CourseId $SomeCourseIdObj -AssignmentOverrides $SomeAssignmentOverridesObj
#>
function Post-CanvasCoursesAssignmentsOverrides {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # Attributes for the new assignment overrides. See Create an assignment override for available attributes
        [Parameter(Mandatory=$true)]
        $AssignmentOverrides
	)

    $uri = "/api/v1/courses/{0}/assignments/overrides" -f $CourseId 

	$Body = @{}

	$Body["assignment_overrides[]"] = $AssignmentOverrides

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Batch update overrides in a course 
.DESCRIPTION
   Updates a list of specified overrides for each assignment. Handles overrides in a transaction, so either all updates are applied or none. See Update an assignment override for available attributes. All current overridden values must be supplied if they are to be retained; e.g. if due_at was overridden, but this PUT omits a value for due_at, due_at will no longer be overridden. If the override is adhoc and student_ids is not supplied, the target override set is unchanged. Target override sets cannot be changed for group or section overrides. Errors are reported in an errors attribute, an array of errors corresponding to inputs. Global errors will be reported as a single element errors array
.EXAMPLE
   PS C:> Put-CanvasCoursesAssignmentsOverrides -CourseId $SomeCourseIdObj -AssignmentOverrides $SomeAssignmentOverridesObj
#>
function Put-CanvasCoursesAssignmentsOverrides {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # Attributes for the updated overrides.
        [Parameter(Mandatory=$true)]
        $AssignmentOverrides
	)

    $uri = "/api/v1/courses/{0}/assignments/overrides" -f $CourseId 

	$Body = @{}

	$Body["assignment_overrides[]"] = $AssignmentOverrides

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   List authentication providers 
.DESCRIPTION
   Returns the list of authentication providers
.EXAMPLE
   PS C:> Get-CanvasAccountsAuthenticationProviders -AccountId $SomeAccountIdObj
#>
function Get-CanvasAccountsAuthenticationProviders {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId
	)

    $uri = "/api/v1/accounts/{0}/authentication_providers" -f $AccountId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Add authentication provider 
.DESCRIPTION
   Add external authentication provider(s) for the account. Services may be CAS, Facebook, GitHub, Google, LDAP, LinkedIn, Microsoft, OpenID Connect, SAML, or Twitter. Each authentication provider is specified as a set of parameters as described below. A provider specification must include an 'auth_type' parameter with a value of 'canvas', 'cas', 'clever', 'facebook', 'github', 'google', 'ldap', 'linkedin', 'microsoft', 'openid_connect', 'saml', or 'twitter'. The other recognized parameters depend on this auth_type; unrecognized parameters are discarded. Provider specifications not specifying a valid auth_type are ignored. You can set the 'position' for any configuration. The config in the 1st position is considered the default. You can set 'jit_provisioning' for any configuration besides Canvas. For Canvas, the additional recognized parameter is: For CAS, the additional recognized parameters are: For Clever, the additional recognized parameters are: For Facebook, the additional recognized parameters are: For GitHub, the additional recognized parameters are: For Google, the additional recognized parameters are: For LDAP, the additional recognized parameters are: For LinkedIn, the additional recognized parameters are: For Microsoft, the additional recognized parameters are: For OpenID Connect, the additional recognized parameters are: For SAML, the additional recognized parameters are: For Twitter, the additional recognized parameters are:
.EXAMPLE
   PS C:> Post-CanvasAccountsAuthenticationProviders -AccountId $SomeAccountIdObj
#>
function Post-CanvasAccountsAuthenticationProviders {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId
	)

    $uri = "/api/v1/accounts/{0}/authentication_providers" -f $AccountId 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   Update authentication provider 
.DESCRIPTION
   Update an authentication provider using the same options as the create endpoint. You can not update an existing provider to a new authentication type.
.EXAMPLE
   PS C:> Put-CanvasAccountsAuthenticationProviders -AccountId $SomeAccountIdObj -Id $SomeIdObj
#>
function Put-CanvasAccountsAuthenticationProviders {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/accounts/{0}/authentication_providers/{1}" -f $AccountId, $Id 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Get authentication provider 
.DESCRIPTION
   Get the specified authentication provider
.EXAMPLE
   PS C:> Get-CanvasAccountsAuthenticationProviders -AccountId $SomeAccountIdObj -Id $SomeIdObj
#>
function Get-CanvasAccountsAuthenticationProviders {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/accounts/{0}/authentication_providers/{1}" -f $AccountId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Delete authentication provider 
.DESCRIPTION
   Delete the config
.EXAMPLE
   PS C:> Delete-CanvasAccountsAuthenticationProviders -AccountId $SomeAccountIdObj -Id $SomeIdObj
#>
function Delete-CanvasAccountsAuthenticationProviders {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/accounts/{0}/authentication_providers/{1}" -f $AccountId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   show account auth settings 
.DESCRIPTION
   The way to get the current state of each account level setting that's relevant to Single Sign On configuration You can list the current state of each setting with âupdate_sso_settingsâ
.EXAMPLE
   PS C:> Get-CanvasAccountsSsoSettings -AccountId $SomeAccountIdObj
#>
function Get-CanvasAccountsSsoSettings {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId
	)

    $uri = "/api/v1/accounts/{0}/sso_settings" -f $AccountId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   update account auth settings 
.DESCRIPTION
   For various cases of mixed SSO configurations, you may need to set some configuration at the account level to handle the particulars of your setup. This endpoint accepts a PUT request to set several possible account settings. All setting are optional on each request, any that are not provided at all are simply retained as is. Any that provide the key but a null-ish value (blank string, null, undefined) will be UN-set. You can list the current state of each setting with âshow_sso_settingsâ
.EXAMPLE
   PS C:> Put-CanvasAccountsSsoSettings -AccountId $SomeAccountIdObj
#>
function Put-CanvasAccountsSsoSettings {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId
	)

    $uri = "/api/v1/accounts/{0}/sso_settings" -f $AccountId 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Query by login. 
.DESCRIPTION
   List authentication events for a given login.
.EXAMPLE
   PS C:> Get-CanvasAuditAuthenticationLogins -LoginId $SomeLoginIdObj -start_time $Somestart_timeObj -end_time $Someend_timeObj
#>
function Get-CanvasAuditAuthenticationLogins {
[CmdletBinding()]

	Param
	(
        # The LoginId
        [Parameter(Mandatory=$true)]
        $LoginId,

        # The beginning of the time range from which you want events.
        [Parameter(Mandatory=$false)]
        $start_time,

        # The end of the time range from which you want events.
        [Parameter(Mandatory=$false)]
        $end_time
	)

    $uri = "/api/v1/audit/authentication/logins/{0}" -f $LoginId 

	$Body = @{}

	if ($start_time) {$Body["start_time"] = $start_time}

	if ($end_time) {$Body["end_time"] = $end_time}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Query by account. 
.DESCRIPTION
   List authentication events for a given account.
.EXAMPLE
   PS C:> Get-CanvasAuditAuthenticationAccounts -AccountId $SomeAccountIdObj -start_time $Somestart_timeObj -end_time $Someend_timeObj
#>
function Get-CanvasAuditAuthenticationAccounts {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The beginning of the time range from which you want events.
        [Parameter(Mandatory=$false)]
        $start_time,

        # The end of the time range from which you want events.
        [Parameter(Mandatory=$false)]
        $end_time
	)

    $uri = "/api/v1/audit/authentication/accounts/{0}" -f $AccountId 

	$Body = @{}

	if ($start_time) {$Body["start_time"] = $start_time}

	if ($end_time) {$Body["end_time"] = $end_time}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Query by user. 
.DESCRIPTION
   List authentication events for a given user.
.EXAMPLE
   PS C:> Get-CanvasAuditAuthenticationUsers -UserId $SomeUserIdObj -start_time $Somestart_timeObj -end_time $Someend_timeObj
#>
function Get-CanvasAuditAuthenticationUsers {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The beginning of the time range from which you want events.
        [Parameter(Mandatory=$false)]
        $start_time,

        # The end of the time range from which you want events.
        [Parameter(Mandatory=$false)]
        $end_time
	)

    $uri = "/api/v1/audit/authentication/users/{0}" -f $UserId 

	$Body = @{}

	if ($start_time) {$Body["start_time"] = $start_time}

	if ($end_time) {$Body["end_time"] = $end_time}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List bookmarks 
.DESCRIPTION
   Returns the list of bookmarks.
.EXAMPLE
   PS C:> Get-CanvasUsersSelfBookmarks
#>
function Get-CanvasUsersSelfBookmarks {
[CmdletBinding()]

    $uri = "/api/v1/users/self/bookmarks" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create bookmark 
.DESCRIPTION
   Creates a bookmark.
.EXAMPLE
   PS C:> Post-CanvasUsersSelfBookmarks -name $SomenameObj -url $SomeurlObj -position $SomepositionObj -data $SomedataObj
#>
function Post-CanvasUsersSelfBookmarks {
[CmdletBinding()]

	Param
	(
        # The name of the bookmark
        [Parameter(Mandatory=$false)]
        $name,

        # The url of the bookmark
        [Parameter(Mandatory=$false)]
        $url,

        # The position of the bookmark. Defaults to the bottom.
        [Parameter(Mandatory=$false)]
        $position,

        # The data associated with the bookmark
        [Parameter(Mandatory=$false)]
        $data
	)

    $uri = "/api/v1/users/self/bookmarks" 

	$Body = @{}

	if ($name) {$Body["name"] = $name}

	if ($url) {$Body["url"] = $url}

	if ($position) {$Body["position"] = $position}

	if ($data) {$Body["data"] = $data}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Get bookmark 
.DESCRIPTION
   Returns the details for a bookmark.
.EXAMPLE
   PS C:> Get-CanvasUsersSelfBookmarks -Id $SomeIdObj
#>
function Get-CanvasUsersSelfBookmarks {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/users/self/bookmarks/{0}" -f $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Update bookmark 
.DESCRIPTION
   Updates a bookmark
.EXAMPLE
   PS C:> Put-CanvasUsersSelfBookmarks -Id $SomeIdObj -name $SomenameObj -url $SomeurlObj -position $SomepositionObj -data $SomedataObj
#>
function Put-CanvasUsersSelfBookmarks {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The name of the bookmark
        [Parameter(Mandatory=$false)]
        $name,

        # The url of the bookmark
        [Parameter(Mandatory=$false)]
        $url,

        # The position of the bookmark. Defaults to the bottom.
        [Parameter(Mandatory=$false)]
        $position,

        # The data associated with the bookmark
        [Parameter(Mandatory=$false)]
        $data
	)

    $uri = "/api/v1/users/self/bookmarks/{0}" -f $Id 

	$Body = @{}

	if ($name) {$Body["name"] = $name}

	if ($url) {$Body["url"] = $url}

	if ($position) {$Body["position"] = $position}

	if ($data) {$Body["data"] = $data}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Delete bookmark 
.DESCRIPTION
   Deletes a bookmark
.EXAMPLE
   PS C:> Delete-CanvasUsersSelfBookmarks -Id $SomeIdObj
#>
function Delete-CanvasUsersSelfBookmarks {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/users/self/bookmarks/{0}" -f $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Get the brand config variables that should be used for this domain 
.DESCRIPTION
   Will redirect to a static json file that has all of the brand variables used by this account. Even though this is a redirect, do not store the redirected url since if the account makes any changes it will redirect to a new url. Needs no authentication.
.EXAMPLE
   PS C:> Get-CanvasBrandVariables
#>
function Get-CanvasBrandVariables {
[CmdletBinding()]

    $uri = "/api/v1/brand_variables" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List calendar events 
.DESCRIPTION
   Retrieve the list of calendar events or assignments for the current user
.EXAMPLE
   PS C:> Get-CanvasCalendarEvents -type $SometypeObj -start_date $Somestart_dateObj -end_date $Someend_dateObj -undated $SomeundatedObj -all_events $Someall_eventsObj -ContextCodes $SomeContextCodesObj -Excludes $SomeExcludesObj
#>
function Get-CanvasCalendarEvents {
[CmdletBinding()]

	Param
	(
        # Defaults to âeventâ
		#Allowed values: event, assignment 
        [Parameter(Mandatory=$false)]
        $type,

        # Only return events since the start_date (inclusive). Defaults to today. The value should be formatted as: yyyy-mm-dd or ISO 8601 YYYY-MM-DDTHH:MM:SSZ.
        [Parameter(Mandatory=$false)]
        $start_date,

        # Only return events before the end_date (inclusive). Defaults to start_date. The value should be formatted as: yyyy-mm-dd or ISO 8601 YYYY-MM-DDTHH:MM:SSZ. If end_date is the same as start_date, then only events on that day are returned.
        [Parameter(Mandatory=$false)]
        $end_date,

        # Defaults to false (dated events only). If true, only return undated events and ignore start_date and end_date.
        [Parameter(Mandatory=$false)]
        $undated,

        # Defaults to false (uses start_date, end_date, and undated criteria). If true, all events are returned, ignoring start_date, end_date, and undated criteria.
        [Parameter(Mandatory=$false)]
        $all_events,

        # List of context codes of courses/groups/users whose events you want to see. If not specified, defaults to the current user (i.e personal calendar, no course/group events). Limited to 10 context codes, additional ones are ignored. The format of this field is the context type, followed by an underscore, followed by the context id. For example: course_42
        [Parameter(Mandatory=$false)]
        $ContextCodes,

        # Array of attributes to exclude. Possible values are âdescriptionâ, âchild_eventsâ and âassignmentâ
        [Parameter(Mandatory=$false)]
        $Excludes
	)

    $uri = "/api/v1/calendar_events" 

	$Body = @{}

	if ($type) {$Body["type"] = $type}

	if ($start_date) {$Body["start_date"] = $start_date}

	if ($end_date) {$Body["end_date"] = $end_date}

	if ($undated) {$Body["undated"] = $undated}

	if ($all_events) {$Body["all_events"] = $all_events}

	if ($ContextCodes) {$Body["context_codes[]"] = $ContextCodes}

	if ($Excludes) {$Body["excludes[]"] = $Excludes}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List calendar events for a user 
.DESCRIPTION
   Retrieve the list of calendar events or assignments for the specified user. To view calendar events for a user other than yourself, you must either be an observer of that user or an administrator.
.EXAMPLE
   PS C:> Get-CanvasUsersCalendarEvents -UserId $SomeUserIdObj -type $SometypeObj -start_date $Somestart_dateObj -end_date $Someend_dateObj -undated $SomeundatedObj -all_events $Someall_eventsObj -ContextCodes $SomeContextCodesObj -Excludes $SomeExcludesObj
#>
function Get-CanvasUsersCalendarEvents {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # Defaults to âeventâ
		#Allowed values: event, assignment 
        [Parameter(Mandatory=$false)]
        $type,

        # Only return events since the start_date (inclusive). Defaults to today. The value should be formatted as: yyyy-mm-dd or ISO 8601 YYYY-MM-DDTHH:MM:SSZ.
        [Parameter(Mandatory=$false)]
        $start_date,

        # Only return events before the end_date (inclusive). Defaults to start_date. The value should be formatted as: yyyy-mm-dd or ISO 8601 YYYY-MM-DDTHH:MM:SSZ. If end_date is the same as start_date, then only events on that day are returned.
        [Parameter(Mandatory=$false)]
        $end_date,

        # Defaults to false (dated events only). If true, only return undated events and ignore start_date and end_date.
        [Parameter(Mandatory=$false)]
        $undated,

        # Defaults to false (uses start_date, end_date, and undated criteria). If true, all events are returned, ignoring start_date, end_date, and undated criteria.
        [Parameter(Mandatory=$false)]
        $all_events,

        # List of context codes of courses/groups/users whose events you want to see. If not specified, defaults to the current user (i.e personal calendar, no course/group events). Limited to 10 context codes, additional ones are ignored. The format of this field is the context type, followed by an underscore, followed by the context id. For example: course_42
        [Parameter(Mandatory=$false)]
        $ContextCodes,

        # Array of attributes to exclude. Possible values are âdescriptionâ, âchild_eventsâ and âassignmentâ
        [Parameter(Mandatory=$false)]
        $Excludes
	)

    $uri = "/api/v1/users/{0}/calendar_events" -f $UserId 

	$Body = @{}

	if ($type) {$Body["type"] = $type}

	if ($start_date) {$Body["start_date"] = $start_date}

	if ($end_date) {$Body["end_date"] = $end_date}

	if ($undated) {$Body["undated"] = $undated}

	if ($all_events) {$Body["all_events"] = $all_events}

	if ($ContextCodes) {$Body["context_codes[]"] = $ContextCodes}

	if ($Excludes) {$Body["excludes[]"] = $Excludes}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create a calendar event 
.DESCRIPTION
   Create and return a new calendar event
.EXAMPLE
   PS C:> Post-CanvasCalendarEvents -ContextCode $SomeContextCodeObj -Title $SomeTitleObj -Description $SomeDescriptionObj -StartAt $SomeStartAtObj -EndAt $SomeEndAtObj -LocationName $SomeLocationNameObj -LocationAddress $SomeLocationAddressObj -TimeZoneEdited $SomeTimeZoneEditedObj -StartAt $SomeStartAtObj -EndAt $SomeEndAtObj -ContextCode $SomeContextCodeObj -Count $SomeCountObj -Interval $SomeIntervalObj -Frequency $SomeFrequencyObj -AppendIterator $SomeAppendIteratorObj
#><#
function Post-CanvasCalendarEvents {
[CmdletBinding()]

	Param
	(
        # Context code of the course/group/user whose calendar this event should be added to.
        [Parameter(Mandatory=$true)]
        $ContextCode,

        # Short title for the calendar event.
        [Parameter(Mandatory=$false)]
        $Title,

        # Longer HTML description of the event.
        [Parameter(Mandatory=$false)]
        $Description,

        # Start date/time of the event.
        [Parameter(Mandatory=$false)]
        $StartAt,

        # End date/time of the event.
        [Parameter(Mandatory=$false)]
        $EndAt,

        # Location name of the event.
        [Parameter(Mandatory=$false)]
        $LocationName,

        # Location address
        [Parameter(Mandatory=$false)]
        $LocationAddress,

        # Time zone of the user editing the event. Allowed time zones are IANA time zones or friendlier Ruby on Rails time zones.
        [Parameter(Mandatory=$false)]
        $TimeZoneEdited,

        # Section-level start time(s) if this is a course event. X can be any identifier, provided that it is consistent across the start_at, end_at and context_code
        [Parameter(Mandatory=$false)]
        $StartAt,

        # Section-level end time(s) if this is a course event.
        [Parameter(Mandatory=$false)]
        $EndAt,

        # Context code(s) corresponding to the section-level start and end time(s).
        [Parameter(Mandatory=$false)]
        $ContextCode,

        # Number of times to copy/duplicate the event.
        [Parameter(Mandatory=$false)]
        $Count,

        # Defaults to 1 if duplicate `count` is set. The interval between the duplicated events.
        [Parameter(Mandatory=$false)]
        $Interval,

        # Defaults to âweeklyâ. The frequency at which to duplicate the event
		#Allowed values: daily, weekly, monthly 
        [Parameter(Mandatory=$false)]
        $Frequency,

        # Defaults to false. If set to `true`, an increasing counter number will be appended to the event title when the event is duplicated. (e.g. Event 1, Event 2, Event 3, etc)
        [Parameter(Mandatory=$false)]
        $AppendIterator
	)

    $uri = "/api/v1/calendar_events" 

	$Body = @{}

	$Body["calendar_event[context_code]"] = $ContextCode

	if ($Title) {$Body["calendar_event[title]"] = $Title}

	if ($Description) {$Body["calendar_event[description]"] = $Description}

	if ($StartAt) {$Body["calendar_event[start_at]"] = $StartAt}

	if ($EndAt) {$Body["calendar_event[end_at]"] = $EndAt}

	if ($LocationName) {$Body["calendar_event[location_name]"] = $LocationName}

	if ($LocationAddress) {$Body["calendar_event[location_address]"] = $LocationAddress}

	if ($TimeZoneEdited) {$Body["calendar_event[time_zone_edited]"] = $TimeZoneEdited}

	if ($StartAt) {$Body["calendar_event[child_event_data][X][start_at]"] = $StartAt}

	if ($EndAt) {$Body["calendar_event[child_event_data][X][end_at]"] = $EndAt}

	if ($ContextCode) {$Body["calendar_event[child_event_data][X][context_code]"] = $ContextCode}

	if ($Count) {$Body["calendar_event[duplicate][count]"] = $Count}

	if ($Interval) {$Body["calendar_event[duplicate][interval]"] = $Interval}

	if ($Frequency) {$Body["calendar_event[duplicate][frequency]"] = $Frequency}

	if ($AppendIterator) {$Body["calendar_event[duplicate][append_iterator]"] = $AppendIterator}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Get a single calendar event or assignment 
.DESCRIPTION
   
.EXAMPLE
   PS C:> Get-CanvasCalendarEvents -Id $SomeIdObj
#>
function Get-CanvasCalendarEvents {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/calendar_events/{0}" -f $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Reserve a time slot 
.DESCRIPTION
   Reserves a particular time slot and return the new reservation
.EXAMPLE
   PS C:> Post-CanvasCalendarEventsReservations -Id $SomeIdObj -participant_id $Someparticipant_idObj -comments $SomecommentsObj -cancel_existing $Somecancel_existingObj
#>
function Post-CanvasCalendarEventsReservations {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # User or group id for whom you are making the reservation (depends on the participant type). Defaults to the current user (or user's candidate group).
        [Parameter(Mandatory=$false)]
        $participant_id,

        # Comments to associate with this reservation
        [Parameter(Mandatory=$false)]
        $comments,

        # Defaults to false. If true, cancel any previous reservation(s) for this participant and appointment group.
        [Parameter(Mandatory=$false)]
        $cancel_existing
	)

    $uri = "/api/v1/calendar_events/{0}/reservations" -f $Id 

	$Body = @{}

	if ($participant_id) {$Body["participant_id"] = $participant_id}

	if ($comments) {$Body["comments"] = $comments}

	if ($cancel_existing) {$Body["cancel_existing"] = $cancel_existing}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Update a calendar event 
.DESCRIPTION
   Update and return a calendar event
.EXAMPLE
   PS C:> Put-CanvasCalendarEvents -Id $SomeIdObj -ContextCode $SomeContextCodeObj -Title $SomeTitleObj -Description $SomeDescriptionObj -StartAt $SomeStartAtObj -EndAt $SomeEndAtObj -LocationName $SomeLocationNameObj -LocationAddress $SomeLocationAddressObj -TimeZoneEdited $SomeTimeZoneEditedObj -StartAt $SomeStartAtObj -EndAt $SomeEndAtObj -ContextCode $SomeContextCodeObj
#><#
function Put-CanvasCalendarEvents {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Context code of the course/group/user to move this event to. Scheduler appointments and events with section-specific times cannot be moved between calendars.
        [Parameter(Mandatory=$false)]
        $ContextCode,

        # Short title for the calendar event.
        [Parameter(Mandatory=$false)]
        $Title,

        # Longer HTML description of the event.
        [Parameter(Mandatory=$false)]
        $Description,

        # Start date/time of the event.
        [Parameter(Mandatory=$false)]
        $StartAt,

        # End date/time of the event.
        [Parameter(Mandatory=$false)]
        $EndAt,

        # Location name of the event.
        [Parameter(Mandatory=$false)]
        $LocationName,

        # Location address
        [Parameter(Mandatory=$false)]
        $LocationAddress,

        # Time zone of the user editing the event. Allowed time zones are IANA time zones or friendlier Ruby on Rails time zones.
        [Parameter(Mandatory=$false)]
        $TimeZoneEdited,

        # Section-level start time(s) if this is a course event. X can be any identifier, provided that it is consistent across the start_at, end_at and context_code
        [Parameter(Mandatory=$false)]
        $StartAt,

        # Section-level end time(s) if this is a course event.
        [Parameter(Mandatory=$false)]
        $EndAt,

        # Context code(s) corresponding to the section-level start and end time(s).
        [Parameter(Mandatory=$false)]
        $ContextCode
	)

    $uri = "/api/v1/calendar_events/{0}" -f $Id 

	$Body = @{}

	if ($ContextCode) {$Body["calendar_event[context_code]"] = $ContextCode}

	if ($Title) {$Body["calendar_event[title]"] = $Title}

	if ($Description) {$Body["calendar_event[description]"] = $Description}

	if ($StartAt) {$Body["calendar_event[start_at]"] = $StartAt}

	if ($EndAt) {$Body["calendar_event[end_at]"] = $EndAt}

	if ($LocationName) {$Body["calendar_event[location_name]"] = $LocationName}

	if ($LocationAddress) {$Body["calendar_event[location_address]"] = $LocationAddress}

	if ($TimeZoneEdited) {$Body["calendar_event[time_zone_edited]"] = $TimeZoneEdited}

	if ($StartAt) {$Body["calendar_event[child_event_data][X][start_at]"] = $StartAt}

	if ($EndAt) {$Body["calendar_event[child_event_data][X][end_at]"] = $EndAt}

	if ($ContextCode) {$Body["calendar_event[child_event_data][X][context_code]"] = $ContextCode}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}
#>

<#
.Synopsis
   Delete a calendar event 
.DESCRIPTION
   Delete an event from the calendar and return the deleted event
.EXAMPLE
   PS C:> Delete-CanvasCalendarEvents -Id $SomeIdObj -cancel_reason $Somecancel_reasonObj
#>
function Delete-CanvasCalendarEvents {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Reason for deleting/canceling the event.
        [Parameter(Mandatory=$false)]
        $cancel_reason
	)

    $uri = "/api/v1/calendar_events/{0}" -f $Id 

	$Body = @{}

	if ($cancel_reason) {$Body["cancel_reason"] = $cancel_reason}

    return Get-CanvasApiResult $uri -Method DELETE -RequestParameters $Body
}


<#
.Synopsis
   Set a course timetable 
.DESCRIPTION
   Creates and updates âtimetableâ events for a course. Can automaticaly generate a series of calendar events based on simple schedules (e.g. âMonday and Wednesday at 2:00pmâ ) Existing timetable events for the course and course sections will be updated if they still are part of the timetable. Otherwise, they will be deleted.
.EXAMPLE
   PS C:> Post-CanvasCoursesCalendarEventsTimetable -CourseId $SomeCourseIdObj -Timetables[CourseSectionId] $SomeTimetables[CourseSectionId]Obj -Timetables[CourseSectionId][Weekdays] $SomeTimetables[CourseSectionId][Weekdays]Obj -Timetables[CourseSectionId][StartTime] $SomeTimetables[CourseSectionId][StartTime]Obj -Timetables[CourseSectionId][EndTime] $SomeTimetables[CourseSectionId][EndTime]Obj -Timetables[CourseSectionId][LocationName] $SomeTimetables[CourseSectionId][LocationName]Obj
#><#
function Post-CanvasCoursesCalendarEventsTimetable {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # An array of timetable objects for the course section specified by course_section_id. If course_section_id is set to âallâ, events will be created for the entire course.
        [Parameter(Mandatory=$false)]
        $Timetables[CourseSectionId],

        # A comma-separated list of abbreviated weekdays (Mon-Monday, Tue-Tuesday, Wed-Wednesday, Thu-Thursday, Fri-Friday, Sat-Saturday, Sun-Sunday)
        [Parameter(Mandatory=$false)]
        $Timetables[CourseSectionId][Weekdays],

        # Time to start each event at (e.g. â9:00 amâ)
        [Parameter(Mandatory=$false)]
        $Timetables[CourseSectionId][StartTime],

        # Time to end each event at (e.g. â9:00 amâ)
        [Parameter(Mandatory=$false)]
        $Timetables[CourseSectionId][EndTime],

        # A location name to set for each event
        [Parameter(Mandatory=$false)]
        $Timetables[CourseSectionId][LocationName]
	)

    $uri = "/api/v1/courses/{0}/calendar_events/timetable" -f $CourseId 

	$Body = @{}

	if ($Timetables[CourseSectionId]) {$Body["timetables[course_section_id][]"] = $Timetables[CourseSectionId]}

	if ($Timetables[CourseSectionId][Weekdays]) {$Body["timetables[course_section_id][][weekdays]"] = $Timetables[CourseSectionId][Weekdays]}

	if ($Timetables[CourseSectionId][StartTime]) {$Body["timetables[course_section_id][][start_time]"] = $Timetables[CourseSectionId][StartTime]}

	if ($Timetables[CourseSectionId][EndTime]) {$Body["timetables[course_section_id][][end_time]"] = $Timetables[CourseSectionId][EndTime]}

	if ($Timetables[CourseSectionId][LocationName]) {$Body["timetables[course_section_id][][location_name]"] = $Timetables[CourseSectionId][LocationName]}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Get course timetable 
.DESCRIPTION
   Returns the last timetable set by the Set a course timetable endpoint
.EXAMPLE
   PS C:> Get-CanvasCoursesCalendarEventsTimetable -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesCalendarEventsTimetable {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/calendar_events/timetable" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create or update events directly for a course timetable 
.DESCRIPTION
   Creates and updates âtimetableâ events for a course or course section. Similar to setting a course timetable, but instead of generating a list of events based on a timetable schedule, this endpoint expects a complete list of events.
.EXAMPLE
   PS C:> Post-CanvasCoursesCalendarEventsTimetableEvents -CourseId $SomeCourseIdObj -course_section_id $Somecourse_section_idObj -Events $SomeEventsObj -Events[StartAt] $SomeEvents[StartAt]Obj -Events[EndAt] $SomeEvents[EndAt]Obj -Events[LocationName] $SomeEvents[LocationName]Obj -Events[Code] $SomeEvents[Code]Obj
#><#
function Post-CanvasCoursesCalendarEventsTimetableEvents {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # Events will be created for the course section specified by course_section_id. If not present, events will be created for the entire course.
        [Parameter(Mandatory=$false)]
        $course_section_id,

        # An array of event objects to use.
        [Parameter(Mandatory=$false)]
        $Events,

        # Start time for the event
        [Parameter(Mandatory=$false)]
        $Events[StartAt],

        # End time for the event
        [Parameter(Mandatory=$false)]
        $Events[EndAt],

        # Location name for the event
        [Parameter(Mandatory=$false)]
        $Events[LocationName],

        # A unique identifier that can be used to update the event at a later time If one is not specified, an identifier will be generated based on the start and end times
        [Parameter(Mandatory=$false)]
        $Events[Code]
	)

    $uri = "/api/v1/courses/{0}/calendar_events/timetable_events" -f $CourseId 

	$Body = @{}

	if ($course_section_id) {$Body["course_section_id"] = $course_section_id}

	if ($Events) {$Body["events[]"] = $Events}

	if ($Events[StartAt]) {$Body["events[][start_at]"] = $Events[StartAt]}

	if ($Events[EndAt]) {$Body["events[][end_at]"] = $Events[EndAt]}

	if ($Events[LocationName]) {$Body["events[][location_name]"] = $Events[LocationName]}

	if ($Events[Code]) {$Body["events[][code]"] = $Events[Code]}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   List collaborations 
.DESCRIPTION
   List collaborations the current user has access to in the context of the course provided in the url. NOTE: this only returns ExternalToolCollaboration type collaborations.
.EXAMPLE
   PS C:> Get-CanvasCoursesCollaborations -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesCollaborations {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/collaborations" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List members of a collaboration. 
.DESCRIPTION
   List the collaborators of a given collaboration
.EXAMPLE
   PS C:> Get-CanvasCollaborationsMembers -Id $SomeIdObj -Include $SomeIncludeObj
#>
function Get-CanvasCollaborationsMembers {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # âcollaborator_lti_idâ: Optional information to include with each member. Represents an identifier to be used for the member in an LTI context.
		#âavatar_image_urlâ: Optional information to include with each member. The url for the avatar of a collaborator with type 'user'.
		#Allowed values: collaborator_lti_id, avatar_image_url 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/collaborations/{0}/members" -f $Id 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List of CommMessages for a user 
.DESCRIPTION
   Retrieve messages sent to a user.
.EXAMPLE
   PS C:> Get-CanvasCommMessages -user_id $Someuser_idObj -start_time $Somestart_timeObj -end_time $Someend_timeObj
#>
function Get-CanvasCommMessages {
[CmdletBinding()]

	Param
	(
        # The user id for whom you want to retrieve CommMessages
        [Parameter(Mandatory=$true)]
        $user_id,

        # The beginning of the time range you want to retrieve message from.
        [Parameter(Mandatory=$false)]
        $start_time,

        # The end of the time range you want to retrieve messages for.
        [Parameter(Mandatory=$false)]
        $end_time
	)

    $uri = "/api/v1/comm_messages" 

	$Body = @{}

	$Body["user_id"] = $user_id

	if ($start_time) {$Body["start_time"] = $start_time}

	if ($end_time) {$Body["end_time"] = $end_time}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List user communication channels 
.DESCRIPTION
   Returns a list of communication channels for the specified user, sorted by position.
.EXAMPLE
   PS C:> Get-CanvasUsersCommunicationChannels -UserId $SomeUserIdObj
#>
function Get-CanvasUsersCommunicationChannels {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId
	)

    $uri = "/api/v1/users/{0}/communication_channels" -f $UserId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create a communication channel 
.DESCRIPTION
   Creates a new communication channel for the specified user.
.EXAMPLE
   PS C:> Post-CanvasUsersCommunicationChannels -UserId $SomeUserIdObj -Address $SomeAddressObj -Type $SomeTypeObj -Token $SomeTokenObj -skip_confirmation $Someskip_confirmationObj
#>
function Post-CanvasUsersCommunicationChannels {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # An email address or SMS number. Not required for âpushâ type channels.
        [Parameter(Mandatory=$true)]
        $Address,

        # The type of communication channel.
		#In order to enable push notification support, the server must be properly configured (via sns.yml) to communicate with Amazon Simple Notification Services, and the developer key used to create the access token from this request must have an SNS ARN configured on it.
		#Allowed values: email, sms, push 
        [Parameter(Mandatory=$true)]
        $Type,

        # A registration id, device token, or equivalent token given to an app when registering with a push notification provider. Only valid for âpushâ type channels.
        [Parameter(Mandatory=$false)]
        $Token,

        # Only valid for site admins and account admins making requests; If true, the channel is automatically validated and no confirmation email or SMS is sent. Otherwise, the user must respond to a confirmation message to confirm the channel.
        [Parameter(Mandatory=$false)]
        $skip_confirmation
	)

    $uri = "/api/v1/users/{0}/communication_channels" -f $UserId 

	$Body = @{}

	$Body["communication_channel[address]"] = $Address

	$Body["communication_channel[type]"] = $Type

	if ($Token) {$Body["communication_channel[token]"] = $Token}

	if ($skip_confirmation) {$Body["skip_confirmation"] = $skip_confirmation}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Delete a communication channel 
.DESCRIPTION
   Delete an existing communication channel.
.EXAMPLE
   PS C:> Delete-CanvasUsersCommunicationChannels -UserId $SomeUserIdObj -Id $SomeIdObj
#>
function Delete-CanvasUsersCommunicationChannels {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/users/{0}/communication_channels/{1}" -f $UserId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   List conferences 
.DESCRIPTION
   Retrieve the list of conferences for this context This API returns a JSON object containing the list of conferences, the key for the list of conferences is âconferencesâ
.EXAMPLE
   PS C:> Get-CanvasCoursesConferences -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesConferences {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/conferences" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List content exports 
.DESCRIPTION
   List the past and pending content export jobs for a course, group, or user. Exports are returned newest first.
.EXAMPLE
   PS C:> Get-CanvasCoursesContentExports -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesContentExports {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/content_exports" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Show content export 
.DESCRIPTION
   Get information about a single content export.
.EXAMPLE
   PS C:> Get-CanvasCoursesContentExports -CourseId $SomeCourseIdObj -Id $SomeIdObj
#>
function Get-CanvasCoursesContentExports {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/content_exports/{1}" -f $CourseId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Export content 
.DESCRIPTION
   Begin a content export job for a course, group, or user. You can use the Progress API to track the progress of the export. The migration's progress is linked to with the progress_url value. When the export completes, use the Show content export endpoint to retrieve a download URL for the exported content.
.EXAMPLE
   PS C:> Post-CanvasCoursesContentExports -CourseId $SomeCourseIdObj -export_type $Someexport_typeObj -skip_notifications $Someskip_notificationsObj
#>
function Post-CanvasCoursesContentExports {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # âcommon_cartridgeâ 
		#Export the contents of the course in the Common Cartridge (.imscc) format
		#âqtiâ 
		#Export quizzes from a course in the QTI format
		#âzipâ 
		#Export files from a course, group, or user in a zip file
		#Allowed values: common_cartridge, qti, zip 
        [Parameter(Mandatory=$true)]
        $export_type,

        # Don't send the notifications about the export to the user. Default: false
        [Parameter(Mandatory=$false)]
        $skip_notifications
	)

    $uri = "/api/v1/courses/{0}/content_exports" -f $CourseId 

	$Body = @{}

	$Body["export_type"] = $export_type

	if ($skip_notifications) {$Body["skip_notifications"] = $skip_notifications}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   List migration issues 
.DESCRIPTION
   Returns paginated migration issues
.EXAMPLE
   PS C:> Get-CanvasAccountsContentMigrationsMigrationIssues -AccountId $SomeAccountIdObj -ContentMigrationId $SomeContentMigrationIdObj
#>
function Get-CanvasAccountsContentMigrationsMigrationIssues {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The ContentMigrationId
        [Parameter(Mandatory=$true)]
        $ContentMigrationId
	)

    $uri = "/api/v1/accounts/{0}/content_migrations/{1}/migration_issues" -f $AccountId, $ContentMigrationId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get a migration issue 
.DESCRIPTION
   Returns data on an individual migration issue
.EXAMPLE
   PS C:> Get-CanvasAccountsContentMigrationsMigrationIssues -AccountId $SomeAccountIdObj -ContentMigrationId $SomeContentMigrationIdObj -Id $SomeIdObj
#>
function Get-CanvasAccountsContentMigrationsMigrationIssues {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The ContentMigrationId
        [Parameter(Mandatory=$true)]
        $ContentMigrationId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/accounts/{0}/content_migrations/{1}/migration_issues/{2}" -f $AccountId, $ContentMigrationId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Update a migration issue 
.DESCRIPTION
   Update the workflow_state of a migration issue
.EXAMPLE
   PS C:> Put-CanvasAccountsContentMigrationsMigrationIssues -AccountId $SomeAccountIdObj -ContentMigrationId $SomeContentMigrationIdObj -Id $SomeIdObj -workflow_state $Someworkflow_stateObj
#>
function Put-CanvasAccountsContentMigrationsMigrationIssues {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The ContentMigrationId
        [Parameter(Mandatory=$true)]
        $ContentMigrationId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Set the workflow_state of the issue.
		#Allowed values: active, resolved 
        [Parameter(Mandatory=$true)]
        $workflow_state
	)

    $uri = "/api/v1/accounts/{0}/content_migrations/{1}/migration_issues/{2}" -f $AccountId, $ContentMigrationId, $Id 

	$Body = @{}

	$Body["workflow_state"] = $workflow_state

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   List content migrations 
.DESCRIPTION
   Returns paginated content migrations
.EXAMPLE
   PS C:> Get-CanvasAccountsContentMigrations -AccountId $SomeAccountIdObj
#>
function Get-CanvasAccountsContentMigrations {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId
	)

    $uri = "/api/v1/accounts/{0}/content_migrations" -f $AccountId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get a content migration 
.DESCRIPTION
   Returns data on an individual content migration
.EXAMPLE
   PS C:> Get-CanvasAccountsContentMigrations -AccountId $SomeAccountIdObj -Id $SomeIdObj
#>
function Get-CanvasAccountsContentMigrations {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/accounts/{0}/content_migrations/{1}" -f $AccountId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create a content migration 
.DESCRIPTION
   Create a content migration. If the migration requires a file to be uploaded the actual processing of the file will start once the file upload process is completed. File uploading works as described in the File Upload Documentation except that the values are set on a pre_attachment sub-hash. For migrations that don't require a file to be uploaded, like course copy, the processing will begin as soon as the migration is created. You can use the Progress API to track the progress of the migration. The migration's progress is linked to with the progress_url value. The two general workflows are: If no file upload is needed: For file uploading:
.EXAMPLE
   PS C:> Post-CanvasAccountsContentMigrations -AccountId $SomeAccountIdObj -migration_type $Somemigration_typeObj -Name $SomeNameObj -* $Some*Obj -FileUrl $SomeFileUrlObj -SourceCourseId $SomeSourceCourseIdObj -FolderId $SomeFolderIdObj -OverwriteQuizzes $SomeOverwriteQuizzesObj -QuestionBankId $SomeQuestionBankIdObj -QuestionBankName $SomeQuestionBankNameObj -ShiftDates $SomeShiftDatesObj -OldStartDate $SomeOldStartDateObj -OldEndDate $SomeOldEndDateObj -NewStartDate $SomeNewStartDateObj -NewEndDate $SomeNewEndDateObj -X $SomeXObj -RemoveDates $SomeRemoveDatesObj
#><#
function Post-CanvasAccountsContentMigrations {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The type of the migration. Use the Migrator endpoint to see all available migrators. Default allowed values: canvas_cartridge_importer, common_cartridge_importer, course_copy_importer, zip_file_importer, qti_converter, moodle_converter
        [Parameter(Mandatory=$true)]
        $migration_type,

        # Required if uploading a file. This is the first step in uploading a file to the content migration. See the File Upload Documentation for details on the file upload workflow.
        [Parameter(Mandatory=$false)]
        $Name,

        # Other file upload properties, See File Upload Documentation
        [Parameter(Mandatory=$false)]
        $*,

        # A URL to download the file from. Must not require authentication.
        [Parameter(Mandatory=$false)]
        $FileUrl,

        # The course to copy from for a course copy migration. (required if doing course copy)
        [Parameter(Mandatory=$false)]
        $SourceCourseId,

        # The folder to unzip the .zip file into for a zip_file_import.
        [Parameter(Mandatory=$false)]
        $FolderId,

        # Whether to overwrite quizzes with the same identifiers between content packages.
        [Parameter(Mandatory=$false)]
        $OverwriteQuizzes,

        # The existing question bank ID to import questions into if not specified in the content package.
        [Parameter(Mandatory=$false)]
        $QuestionBankId,

        # The question bank to import questions into if not specified in the content package, if both bank id and name are set, id will take precedence.
        [Parameter(Mandatory=$false)]
        $QuestionBankName,

        # Whether to shift dates in the copied course
        [Parameter(Mandatory=$false)]
        $ShiftDates,

        # The original start date of the source content/course
        [Parameter(Mandatory=$false)]
        $OldStartDate,

        # The original end date of the source content/course
        [Parameter(Mandatory=$false)]
        $OldEndDate,

        # The new start date for the content/course
        [Parameter(Mandatory=$false)]
        $NewStartDate,

        # The new end date for the source content/course
        [Parameter(Mandatory=$false)]
        $NewEndDate,

        # Move anything scheduled for day 'X' to the specified day. (0-Sunday, 1-Monday, 2-Tuesday, 3-Wednesday, 4-Thursday, 5-Friday, 6-Saturday)
        [Parameter(Mandatory=$false)]
        $X,

        # Whether to remove dates in the copied course. Cannot be used in conjunction with shift_dates.
        [Parameter(Mandatory=$false)]
        $RemoveDates
	)

    $uri = "/api/v1/accounts/{0}/content_migrations" -f $AccountId 

	$Body = @{}

	$Body["migration_type"] = $migration_type

	if ($Name) {$Body["pre_attachment[name]"] = $Name}

	if ($*) {$Body["pre_attachment[*]"] = $*}

	if ($FileUrl) {$Body["settings[file_url]"] = $FileUrl}

	if ($SourceCourseId) {$Body["settings[source_course_id]"] = $SourceCourseId}

	if ($FolderId) {$Body["settings[folder_id]"] = $FolderId}

	if ($OverwriteQuizzes) {$Body["settings[overwrite_quizzes]"] = $OverwriteQuizzes}

	if ($QuestionBankId) {$Body["settings[question_bank_id]"] = $QuestionBankId}

	if ($QuestionBankName) {$Body["settings[question_bank_name]"] = $QuestionBankName}

	if ($ShiftDates) {$Body["date_shift_options[shift_dates]"] = $ShiftDates}

	if ($OldStartDate) {$Body["date_shift_options[old_start_date]"] = $OldStartDate}

	if ($OldEndDate) {$Body["date_shift_options[old_end_date]"] = $OldEndDate}

	if ($NewStartDate) {$Body["date_shift_options[new_start_date]"] = $NewStartDate}

	if ($NewEndDate) {$Body["date_shift_options[new_end_date]"] = $NewEndDate}

	if ($X) {$Body["date_shift_options[day_substitutions][X]"] = $X}

	if ($RemoveDates) {$Body["date_shift_options[remove_dates]"] = $RemoveDates}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Update a content migration 
.DESCRIPTION
   Update a content migration. Takes same arguments as create except that you can't change the migration type. However, changing most settings after the migration process has started will not do anything. Generally updating the content migration will be used when there is a file upload problem. If the first upload has a problem you can supply new pre_attachment values to start the process again.
.EXAMPLE
   PS C:> Put-CanvasAccountsContentMigrations -AccountId $SomeAccountIdObj -Id $SomeIdObj
#>
function Put-CanvasAccountsContentMigrations {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/accounts/{0}/content_migrations/{1}" -f $AccountId, $Id 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   List Migration Systems 
.DESCRIPTION
   Lists the currently available migration types. These values may change.
.EXAMPLE
   PS C:> Get-CanvasAccountsContentMigrationsMigrators -AccountId $SomeAccountIdObj
#>
function Get-CanvasAccountsContentMigrationsMigrators {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId
	)

    $uri = "/api/v1/accounts/{0}/content_migrations/migrators" -f $AccountId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List conversations 
.DESCRIPTION
   Returns the list of conversations for the current user, most recent ones first.
.EXAMPLE
   PS C:> Get-CanvasConversations -scope $SomescopeObj -Filter $SomeFilterObj -filter_mode $Somefilter_modeObj -interleave_submissions $Someinterleave_submissionsObj -include_all_conversation_ids $Someinclude_all_conversation_idsObj -Include $SomeIncludeObj
#>
function Get-CanvasConversations {
[CmdletBinding()]

	Param
	(
        # When set, only return conversations of the specified type. For example, set to âunreadâ to return only conversations that haven't been read. The default behavior is to return all non-archived conversations (i.e. read and unread).
		#Allowed values: unread, starred, archived 
        [Parameter(Mandatory=$false)]
        $scope,

        # When set, only return conversations for the specified courses, groups or users. The id should be prefixed with its type, e.g. âuser_123â or âcourse_456â. Can be an array (by setting âfilter[]â) or single value (by setting âfilterâ)
        [Parameter(Mandatory=$false)]
        $Filter,

        # When filter[] contains multiple filters, combine them with this mode, filtering conversations that at have at least all of the contexts (âandâ) or at least one of the contexts (âorâ)
		#Allowed values: and, or, default or 
        [Parameter(Mandatory=$false)]
        $filter_mode,

        # (Obsolete) Submissions are no longer linked to conversations. This parameter is ignored.
        [Parameter(Mandatory=$false)]
        $interleave_submissions,

        # Default is false. If true, the top-level element of the response will be an object rather than an array, and will have the keys âconversationsâ which will contain the paged conversation data, and âconversation_idsâ which will contain the ids of all conversations under this scope/filter in the same order.
        [Parameter(Mandatory=$false)]
        $include_all_conversation_ids,

        # âparticipant_avatarsâ 
		#Optionally include an âavatar_urlâ key for each user participanting in the conversation
		#Allowed values: participant_avatars 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/conversations" 

	$Body = @{}

	if ($scope) {$Body["scope"] = $scope}

	if ($Filter) {$Body["filter[]"] = $Filter}

	if ($filter_mode) {$Body["filter_mode"] = $filter_mode}

	if ($interleave_submissions) {$Body["interleave_submissions"] = $interleave_submissions}

	if ($include_all_conversation_ids) {$Body["include_all_conversation_ids"] = $include_all_conversation_ids}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create a conversation 
.DESCRIPTION
   Create a new conversation with one or more recipients. If there is already an existing private conversation with the given recipients, it will be reused.
.EXAMPLE
   PS C:> Post-CanvasConversations -Recipients $SomeRecipientsObj -subject $SomesubjectObj -body $SomebodyObj -group_conversation $Somegroup_conversationObj -AttachmentIds $SomeAttachmentIdsObj -media_comment_id $Somemedia_comment_idObj -media_comment_type $Somemedia_comment_typeObj -user_note $Someuser_noteObj -mode $SomemodeObj -scope $SomescopeObj -Filter $SomeFilterObj -filter_mode $Somefilter_modeObj -context_code $Somecontext_codeObj
#>
function Post-CanvasConversations {
[CmdletBinding()]

	Param
	(
        # An array of recipient ids. These may be user ids or course/group ids prefixed with âcourse_â or âgroup_â respectively, e.g. recipients[]=1&recipients=2&recipients[]=course_3
        [Parameter(Mandatory=$true)]
        $Recipients,

        # The subject of the conversation. This is ignored when reusing a conversation. Maximum length is 255 characters.
        [Parameter(Mandatory=$false)]
        $subject,

        # The message to be sent
        [Parameter(Mandatory=$true)]
        $body,

        # Defaults to false. If true, this will be a group conversation (i.e. all recipients may see all messages and replies). If false, individual private conversations will be started with each recipient. Must be set false if the number of recipients is over the set maximum (default is 100).
        [Parameter(Mandatory=$false)]
        $group_conversation,

        # An array of attachments ids. These must be files that have been previously uploaded to the sender's âconversation attachmentsâ folder.
        [Parameter(Mandatory=$false)]
        $AttachmentIds,

        # Media comment id of an audio of video file to be associated with this message.
        [Parameter(Mandatory=$false)]
        $media_comment_id,

        # Type of the associated media file
		#Allowed values: audio, video 
        [Parameter(Mandatory=$false)]
        $media_comment_type,

        # Will add a faculty journal entry for each recipient as long as the user making the api call has permission, the recipient is a student and faculty journals are enabled in the account.
        [Parameter(Mandatory=$false)]
        $user_note,

        # Determines whether the messages will be created/sent synchronously or asynchronously. Defaults to sync, and this option is ignored if this is a group conversation or there is just one recipient (i.e. it must be a bulk private message). When sent async, the response will be an empty array (batch status can be queried via the batches API)
		#Allowed values: sync, async 
        [Parameter(Mandatory=$false)]
        $mode,

        # Used when generating âvisibleâ in the API response. See the explanation under the index API action
		#Allowed values: unread, starred, archived 
        [Parameter(Mandatory=$false)]
        $scope,

        # Used when generating âvisibleâ in the API response. See the explanation under the index API action
        [Parameter(Mandatory=$false)]
        $Filter,

        # Used when generating âvisibleâ in the API response. See the explanation under the index API action
		#Allowed values: and, or, default or 
        [Parameter(Mandatory=$false)]
        $filter_mode,

        # The course or group that is the context for this conversation. Same format as courses or groups in the recipients argument.
        [Parameter(Mandatory=$false)]
        $context_code
	)

    $uri = "/api/v1/conversations" 

	$Body = @{}

	$Body["recipients[]"] = $Recipients

	if ($subject) {$Body["subject"] = $subject}

	$Body["body"] = $body

	if ($group_conversation) {$Body["group_conversation"] = $group_conversation}

	if ($AttachmentIds) {$Body["attachment_ids[]"] = $AttachmentIds}

	if ($media_comment_id) {$Body["media_comment_id"] = $media_comment_id}

	if ($media_comment_type) {$Body["media_comment_type"] = $media_comment_type}

	if ($user_note) {$Body["user_note"] = $user_note}

	if ($mode) {$Body["mode"] = $mode}

	if ($scope) {$Body["scope"] = $scope}

	if ($Filter) {$Body["filter[]"] = $Filter}

	if ($filter_mode) {$Body["filter_mode"] = $filter_mode}

	if ($context_code) {$Body["context_code"] = $context_code}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Get running batches 
.DESCRIPTION
   Returns any currently running conversation batches for the current user. Conversation batches are created when a bulk private message is sent asynchronously (see the mode argument to the create API action).
.EXAMPLE
   PS C:> Get-CanvasConversationsBatches
#>
function Get-CanvasConversationsBatches {
[CmdletBinding()]

    $uri = "/api/v1/conversations/batches" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get a single conversation 
.DESCRIPTION
   Returns information for a single conversation for the current user. Response includes all fields that are present in the list/index action as well as messages and extended participant information.
.EXAMPLE
   PS C:> Get-CanvasConversations -Id $SomeIdObj -interleave_submissions $Someinterleave_submissionsObj -scope $SomescopeObj -Filter $SomeFilterObj -filter_mode $Somefilter_modeObj -auto_mark_as_read $Someauto_mark_as_readObj
#>
function Get-CanvasConversations {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # (Obsolete) Submissions are no longer linked to conversations. This parameter is ignored.
        [Parameter(Mandatory=$false)]
        $interleave_submissions,

        # Used when generating âvisibleâ in the API response. See the explanation under the index API action
		#Allowed values: unread, starred, archived 
        [Parameter(Mandatory=$false)]
        $scope,

        # Used when generating âvisibleâ in the API response. See the explanation under the index API action
        [Parameter(Mandatory=$false)]
        $Filter,

        # Used when generating âvisibleâ in the API response. See the explanation under the index API action
		#Allowed values: and, or, default or 
        [Parameter(Mandatory=$false)]
        $filter_mode,

        # Default true. If true, unread conversations will be automatically marked as read. This will default to false in a future API release, so clients should explicitly send true if that is the desired behavior.
        [Parameter(Mandatory=$false)]
        $auto_mark_as_read
	)

    $uri = "/api/v1/conversations/{0}" -f $Id 

	$Body = @{}

	if ($interleave_submissions) {$Body["interleave_submissions"] = $interleave_submissions}

	if ($scope) {$Body["scope"] = $scope}

	if ($Filter) {$Body["filter[]"] = $Filter}

	if ($filter_mode) {$Body["filter_mode"] = $filter_mode}

	if ($auto_mark_as_read) {$Body["auto_mark_as_read"] = $auto_mark_as_read}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Edit a conversation 
.DESCRIPTION
   Updates attributes for a single conversation.
.EXAMPLE
   PS C:> Put-CanvasConversations -Id $SomeIdObj -WorkflowState $SomeWorkflowStateObj -Subscribed $SomeSubscribedObj -Starred $SomeStarredObj -scope $SomescopeObj -Filter $SomeFilterObj -filter_mode $Somefilter_modeObj
#>
function Put-CanvasConversations {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Change the state of this conversation
		#Allowed values: read, unread, archived 
        [Parameter(Mandatory=$false)]
        $WorkflowState,

        # Toggle the current user's subscription to the conversation (only valid for group conversations). If unsubscribed, the user will still have access to the latest messages, but the conversation won't be automatically flagged as unread, nor will it jump to the top of the inbox.
        [Parameter(Mandatory=$false)]
        $Subscribed,

        # Toggle the starred state of the current user's view of the conversation.
        [Parameter(Mandatory=$false)]
        $Starred,

        # Used when generating âvisibleâ in the API response. See the explanation under the index API action
		#Allowed values: unread, starred, archived 
        [Parameter(Mandatory=$false)]
        $scope,

        # Used when generating âvisibleâ in the API response. See the explanation under the index API action
        [Parameter(Mandatory=$false)]
        $Filter,

        # Used when generating âvisibleâ in the API response. See the explanation under the index API action
		#Allowed values: and, or, default or 
        [Parameter(Mandatory=$false)]
        $filter_mode
	)

    $uri = "/api/v1/conversations/{0}" -f $Id 

	$Body = @{}

	if ($WorkflowState) {$Body["conversation[workflow_state]"] = $WorkflowState}

	if ($Subscribed) {$Body["conversation[subscribed]"] = $Subscribed}

	if ($Starred) {$Body["conversation[starred]"] = $Starred}

	if ($scope) {$Body["scope"] = $scope}

	if ($Filter) {$Body["filter[]"] = $Filter}

	if ($filter_mode) {$Body["filter_mode"] = $filter_mode}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Mark all as read 
.DESCRIPTION
   Mark all conversations as read.
.EXAMPLE
   PS C:> Post-CanvasConversationsMarkAllAsRead
#>
function Post-CanvasConversationsMarkAllAsRead {
[CmdletBinding()]

    $uri = "/api/v1/conversations/mark_all_as_read" 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   Delete a conversation 
.DESCRIPTION
   Delete this conversation and its messages. Note that this only deletes this user's view of the conversation. Response includes same fields as UPDATE action
.EXAMPLE
   PS C:> Delete-CanvasConversations -Id $SomeIdObj
#>
function Delete-CanvasConversations {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/conversations/{0}" -f $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Add recipients 
.DESCRIPTION
   Add recipients to an existing group conversation. Response is similar to the GET/show action, except that only includes the latest message (e.g. âjoe was added to the conversation by bobâ)
.EXAMPLE
   PS C:> Post-CanvasConversationsAddRecipients -Id $SomeIdObj -Recipients $SomeRecipientsObj
#>
function Post-CanvasConversationsAddRecipients {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # An array of recipient ids. These may be user ids or course/group ids prefixed with âcourse_â or âgroup_â respectively, e.g. recipients[]=1&recipients=2&recipients[]=course_3
        [Parameter(Mandatory=$true)]
        $Recipients
	)

    $uri = "/api/v1/conversations/{0}/add_recipients" -f $Id 

	$Body = @{}

	$Body["recipients[]"] = $Recipients

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Add a message 
.DESCRIPTION
   Add a message to an existing conversation. Response is similar to the GET/show action, except that only includes the latest message (i.e. what we just sent) An array of user ids. Defaults to all of the current conversation recipients. To explicitly send a message to no other recipients, this array should consist of the logged-in user id. An array of message ids from this conversation to send to recipients of the new message. Recipients who already had a copy of included messages will not be affected.
.EXAMPLE
   PS C:> Post-CanvasConversationsAddMessage -Id $SomeIdObj -body $SomebodyObj -AttachmentIds $SomeAttachmentIdsObj -media_comment_id $Somemedia_comment_idObj -media_comment_type $Somemedia_comment_typeObj -Recipients $SomeRecipientsObj -IncludedMessages $SomeIncludedMessagesObj -user_note $Someuser_noteObj
#>
function Post-CanvasConversationsAddMessage {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The message to be sent.
        [Parameter(Mandatory=$true)]
        $body,

        # An array of attachments ids. These must be files that have been previously uploaded to the sender's âconversation attachmentsâ folder.
        [Parameter(Mandatory=$false)]
        $AttachmentIds,

        # Media comment id of an audio of video file to be associated with this message.
        [Parameter(Mandatory=$false)]
        $media_comment_id,

        # Type of the associated media file.
		#Allowed values: audio, video 
        [Parameter(Mandatory=$false)]
        $media_comment_type,

        # no description
        [Parameter(Mandatory=$false)]
        $Recipients,

        # no description
        [Parameter(Mandatory=$false)]
        $IncludedMessages,

        # Will add a faculty journal entry for each recipient as long as the user making the api call has permission, the recipient is a student and faculty journals are enabled in the account.
        [Parameter(Mandatory=$false)]
        $user_note
	)

    $uri = "/api/v1/conversations/{0}/add_message" -f $Id 

	$Body = @{}

	$Body["body"] = $body

	if ($AttachmentIds) {$Body["attachment_ids[]"] = $AttachmentIds}

	if ($media_comment_id) {$Body["media_comment_id"] = $media_comment_id}

	if ($media_comment_type) {$Body["media_comment_type"] = $media_comment_type}

	if ($Recipients) {$Body["recipients[]"] = $Recipients}

	if ($IncludedMessages) {$Body["included_messages[]"] = $IncludedMessages}

	if ($user_note) {$Body["user_note"] = $user_note}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Delete a message 
.DESCRIPTION
   Delete messages from this conversation. Note that this only affects this user's view of the conversation. If all messages are deleted, the conversation will be as well (equivalent to DELETE)
.EXAMPLE
   PS C:> Post-CanvasConversationsRemoveMessages -Id $SomeIdObj -Remove $SomeRemoveObj
#>
function Post-CanvasConversationsRemoveMessages {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Array of message ids to be deleted
        [Parameter(Mandatory=$true)]
        $Remove
	)

    $uri = "/api/v1/conversations/{0}/remove_messages" -f $Id 

	$Body = @{}

	$Body["remove[]"] = $Remove

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Batch update conversations 
.DESCRIPTION
   Perform a change on a set of conversations. Operates asynchronously; use the progress endpoint to query the status of an operation.
.EXAMPLE
   PS C:> Put-CanvasConversations -ConversationIds $SomeConversationIdsObj -event $SomeeventObj
#>
function Put-CanvasConversations {
[CmdletBinding()]

	Param
	(
        # List of conversations to update. Limited to 500 conversations.
        [Parameter(Mandatory=$true)]
        $ConversationIds,

        # The action to take on each conversation.
		#Allowed values: mark_as_read, mark_as_unread, star, unstar, archive, destroy 
        [Parameter(Mandatory=$true)]
        $event
	)

    $uri = "/api/v1/conversations" 

	$Body = @{}

	$Body["conversation_ids[]"] = $ConversationIds

	$Body["event"] = $event

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Find recipients 
.DESCRIPTION
   Deprecated, see the Find recipients endpoint in the Search API
.EXAMPLE
   PS C:> Get-CanvasConversationsFindRecipients
#>
function Get-CanvasConversationsFindRecipients {
[CmdletBinding()]

    $uri = "/api/v1/conversations/find_recipients" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Unread count 
.DESCRIPTION
   Get the number of unread conversations for the current user
.EXAMPLE
   PS C:> Get-CanvasConversationsUnreadCount
#>
function Get-CanvasConversationsUnreadCount {
[CmdletBinding()]

    $uri = "/api/v1/conversations/unread_count" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Query by course. 
.DESCRIPTION
   List course change events for a given course.
.EXAMPLE
   PS C:> Get-CanvasAuditCourseCourses -CourseId $SomeCourseIdObj -start_time $Somestart_timeObj -end_time $Someend_timeObj
#>
function Get-CanvasAuditCourseCourses {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The beginning of the time range from which you want events.
        [Parameter(Mandatory=$false)]
        $start_time,

        # The end of the time range from which you want events.
        [Parameter(Mandatory=$false)]
        $end_time
	)

    $uri = "/api/v1/audit/course/courses/{0}" -f $CourseId 

	$Body = @{}

	if ($start_time) {$Body["start_time"] = $start_time}

	if ($end_time) {$Body["end_time"] = $end_time}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Set extensions for student quiz submissions 
.DESCRIPTION
   Responses
.EXAMPLE
   PS C:> Post-CanvasCoursesQuizExtensions -CourseId $SomeCourseIdObj -user_id $Someuser_idObj -extra_attempts $Someextra_attemptsObj -extra_time $Someextra_timeObj -manually_unlocked $Somemanually_unlockedObj -extend_from_now $Someextend_from_nowObj -extend_from_end_at $Someextend_from_end_atObj
#>
function Post-CanvasCoursesQuizExtensions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The ID of the user we want to add quiz extensions for.
        [Parameter(Mandatory=$true)]
        $user_id,

        # Number of times the student is allowed to re-take the quiz over the multiple-attempt limit. This is limited to 1000 attempts or less.
        [Parameter(Mandatory=$false)]
        $extra_attempts,

        # The number of extra minutes to allow for all attempts. This will add to the existing time limit on the submission. This is limited to 10080 minutes (1 week)
        [Parameter(Mandatory=$false)]
        $extra_time,

        # Allow the student to take the quiz even if it's locked for everyone else.
        [Parameter(Mandatory=$false)]
        $manually_unlocked,

        # The number of minutes to extend the quiz from the current time. This is mutually exclusive to extend_from_end_at. This is limited to 1440 minutes (24 hours)
        [Parameter(Mandatory=$false)]
        $extend_from_now,

        # The number of minutes to extend the quiz beyond the quiz's current ending time. This is mutually exclusive to extend_from_now. This is limited to 1440 minutes (24 hours)
        [Parameter(Mandatory=$false)]
        $extend_from_end_at
	)

    $uri = "/api/v1/courses/{0}/quiz_extensions" -f $CourseId 

	$Body = @{}

	$Body["user_id"] = $user_id

	if ($extra_attempts) {$Body["extra_attempts"] = $extra_attempts}

	if ($extra_time) {$Body["extra_time"] = $extra_time}

	if ($manually_unlocked) {$Body["manually_unlocked"] = $manually_unlocked}

	if ($extend_from_now) {$Body["extend_from_now"] = $extend_from_now}

	if ($extend_from_end_at) {$Body["extend_from_end_at"] = $extend_from_end_at}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   List your courses 
.DESCRIPTION
   Returns the list of active courses for the current user.
.EXAMPLE
   PS C:> Get-CanvasCourses -enrollment_type $Someenrollment_typeObj -enrollment_role $Someenrollment_roleObj -enrollment_role_id $Someenrollment_role_idObj -enrollment_state $Someenrollment_stateObj -Include $SomeIncludeObj -State $SomeStateObj
#>
function Get-CanvasCourses {
[CmdletBinding()]

	Param
	(
        # When set, only return courses where the user is enrolled as this type. For example, set to âteacherâ to return only courses where the user is enrolled as a Teacher. This argument is ignored if enrollment_role is given.
		#Allowed values: teacher, student, ta, observer, designer 
        [Parameter(Mandatory=$false)]
        $enrollment_type,

        # Deprecated When set, only return courses where the user is enrolled with the specified course-level role. This can be a role created with the Add Role API or a base role type of 'StudentEnrollment', 'TeacherEnrollment', 'TaEnrollment', 'ObserverEnrollment', or 'DesignerEnrollment'.
        [Parameter(Mandatory=$false)]
        $enrollment_role,

        # When set, only return courses where the user is enrolled with the specified course-level role. This can be a role created with the Add Role API or a built_in role type of 'StudentEnrollment', 'TeacherEnrollment', 'TaEnrollment', 'ObserverEnrollment', or 'DesignerEnrollment'.
        [Parameter(Mandatory=$false)]
        $enrollment_role_id,

        # When set, only return courses where the user has an enrollment with the given state. This will respect section/course/term date overrides.
		#Allowed values: active, invited_or_pending, completed 
        [Parameter(Mandatory=$false)]
        $enrollment_state,

        # âneeds_grading_countâ: Optional information to include with each Course. When needs_grading_count is given, and the current user has grading rights, the total number of submissions needing grading for all assignments is returned.
		#âsyllabus_bodyâ: Optional information to include with each Course. When syllabus_body is given the user-generated html for the course syllabus is returned.
		#âpublic_descriptionâ: Optional information to include with each Course. When public_description is given the user-generated text for the course public description is returned.
		#âtotal_scoresâ: Optional information to include with each Course. When total_scores is given, any student enrollments will also include the fields 'computed_current_score', 'computed_final_score', 'computed_current_grade', and 'computed_final_grade' (see Enrollment documentation for more information on these fields). This argument is ignored if the course is configured to hide final grades.
		#âcurrent_grading_period_scoresâ: Optional information to include with each Course. When current_grading_period_scores is given and total_scores is given, any student enrollments will also include the fields 'multiple_grading_periods_enabled', 'totals_for_all_grading_periods_option', 'current_grading_period_title', 'current_grading_period_id', current_period_computed_current_score', 'current_period_computed_final_score', 'current_period_computed_current_grade', and 'current_period_computed_final_grade' (see Enrollment documentation for more information on these fields). In addition, when this argument is passed, the course will have a 'multiple_grading_periods_enabled' attribute on it. This argument is ignored if the course is configured to hide final grades or if the total_scores argument is not included.
		#âtermâ: Optional information to include with each Course. When term is given, the information for the enrollment term for each course is returned.
		#âcourse_progressâ: Optional information to include with each Course. When course_progress is given, each course will include a 'course_progress' object with the fields: 'requirement_count', an integer specifying the total number of requirements in the course, 'requirement_completed_count', an integer specifying the total number of requirements in this course that have been completed, and 'next_requirement_url', a string url to the next requirement item, and 'completed_at', the date the course was completed (null if incomplete). 'next_requirement_url' will be null if all requirements have been completed or the current module does not require sequential progress. âcourse_progressâ will return an error message if the course is not module based or the user is not enrolled as a student in the course.
		#âsectionsâ: Section enrollment information to include with each Course. Returns an array of hashes containing the section ID (id), section name (name), start and end dates (start_at, end_at), as well as the enrollment type (enrollment_role, e.g. 'StudentEnrollment').
		#âstorage_quota_used_mbâ: The amount of storage space used by the files in this course
		#âtotal_studentsâ: Optional information to include with each Course. Returns an integer for the total amount of active and invited students.
		#âpassback_statusâ: Include the grade passback_status
		#âfavoritesâ: Optional information to include with each Course. Indicates if the user has marked the course as a favorite course.
		#âteachersâ: Teacher information to include with each Course. Returns an array of hashes containing the UserDisplay information for each teacher in the course.
		#âobserved_usersâ: Optional information to include with each Course. Will include data for observed users if the current user has an observer enrollment.
		#âtabsâ: Optional information to include with each Course. Will include the list of tabs configured for each course. See the List available tabs API for more information.
		#Allowed values: needs_grading_count, syllabus_body, public_description, total_scores, current_grading_period_scores, term, course_progress, sections, storage_quota_used_mb, total_students, passback_status, favorites, teachers, observed_users 
        [Parameter(Mandatory=$false)]
        $Include,

        # If set, only return courses that are in the given state(s). By default, âavailableâ is returned for students and observers, and anything except âdeletedâ, for all other enrollment types
		#Allowed values: unpublished, available, completed, deleted 
        [Parameter(Mandatory=$false)]
        $State
	)

    $uri = "/api/v1/courses" 

	$Body = @{}

	if ($enrollment_type) {$Body["enrollment_type"] = $enrollment_type}

	if ($enrollment_role) {$Body["enrollment_role"] = $enrollment_role}

	if ($enrollment_role_id) {$Body["enrollment_role_id"] = $enrollment_role_id}

	if ($enrollment_state) {$Body["enrollment_state"] = $enrollment_state}

	if ($Include) {$Body["include[]"] = $Include}

	if ($State) {$Body["state[]"] = $State}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List courses for a user 
.DESCRIPTION
   Returns a list of active courses for this user. To view the course list for a user other than yourself, you must be either an observer of that user or an administrator.
.EXAMPLE
   PS C:> Get-CanvasUsersCourses -UserId $SomeUserIdObj -Include $SomeIncludeObj -State $SomeStateObj -enrollment_state $Someenrollment_stateObj
#>
function Get-CanvasUsersCourses {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # âneeds_grading_countâ: Optional information to include with each Course. When needs_grading_count is given, and the current user has grading rights, the total number of submissions needing grading for all assignments is returned.
		#âsyllabus_bodyâ: Optional information to include with each Course. When syllabus_body is given the user-generated html for the course syllabus is returned.
		#âpublic_descriptionâ: Optional information to include with each Course. When public_description is given the user-generated text for the course public description is returned.
		#âtotal_scoresâ: Optional information to include with each Course. When total_scores is given, any student enrollments will also include the fields 'computed_current_score', 'computed_final_score', 'computed_current_grade', and 'computed_final_grade' (see Enrollment documentation for more information on these fields). This argument is ignored if the course is configured to hide final grades.
		#âcurrent_grading_period_scoresâ: Optional information to include with each Course. When current_grading_period_scores is given and total_scores is given, any student enrollments will also include the fields 'multiple_grading_periods_enabled', 'totals_for_all_grading_periods_option', 'current_grading_period_title', 'current_grading_period_id', current_period_computed_current_score', 'current_period_computed_final_score', 'current_period_computed_current_grade', and 'current_period_computed_final_grade' (see Enrollment documentation for more information on these fields). In addition, when this argument is passed, the course will have a 'multiple_grading_periods_enabled' attribute on it. This argument is ignored if the course is configured to hide final grades or if the total_scores argument is not included.
		#âtermâ: Optional information to include with each Course. When term is given, the information for the enrollment term for each course is returned.
		#âcourse_progressâ: Optional information to include with each Course. When course_progress is given, each course will include a 'course_progress' object with the fields: 'requirement_count', an integer specifying the total number of requirements in the course, 'requirement_completed_count', an integer specifying the total number of requirements in this course that have been completed, and 'next_requirement_url', a string url to the next requirement item, and 'completed_at', the date the course was completed (null if incomplete). 'next_requirement_url' will be null if all requirements have been completed or the current module does not require sequential progress. âcourse_progressâ will return an error message if the course is not module based or the user is not enrolled as a student in the course.
		#âsectionsâ: Section enrollment information to include with each Course. Returns an array of hashes containing the section ID (id), section name (name), start and end dates (start_at, end_at), as well as the enrollment type (enrollment_role, e.g. 'StudentEnrollment').
		#âstorage_quota_used_mbâ: The amount of storage space used by the files in this course
		#âtotal_studentsâ: Optional information to include with each Course. Returns an integer for the total amount of active and invited students.
		#âpassback_statusâ: Include the grade passback_status
		#âfavoritesâ: Optional information to include with each Course. Indicates if the user has marked the course as a favorite course.
		#âteachersâ: Teacher information to include with each Course. Returns an array of hashes containing the UserDisplay information for each teacher in the course.
		#âobserved_usersâ: Optional information to include with each Course. Will include data for observed users if the current user has an observer enrollment.
		#âtabsâ: Optional information to include with each Course. Will include the list of tabs configured for each course. See the List available tabs API for more information.
		#Allowed values: needs_grading_count, syllabus_body, public_description, total_scores, current_grading_period_scores, term, course_progress, sections, storage_quota_used_mb, total_students, passback_status, favorites, teachers, observed_users 
        [Parameter(Mandatory=$false)]
        $Include,

        # If set, only return courses that are in the given state(s). By default, âavailableâ is returned for students and observers, and anything except âdeletedâ, for all other enrollment types
		#Allowed values: unpublished, available, completed, deleted 
        [Parameter(Mandatory=$false)]
        $State,

        # When set, only return courses where the user has an enrollment with the given state. This will respect section/course/term date overrides.
		#Allowed values: active, invited_or_pending, completed 
        [Parameter(Mandatory=$false)]
        $enrollment_state
	)

    $uri = "/api/v1/users/{0}/courses" -f $UserId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

	if ($State) {$Body["state[]"] = $State}

	if ($enrollment_state) {$Body["enrollment_state"] = $enrollment_state}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create a new course 
.DESCRIPTION
   Create a new course
.EXAMPLE
   PS C:> Post-CanvasAccountsCourses -AccountId $SomeAccountIdObj -Name $SomeNameObj -CourseCode $SomeCourseCodeObj -StartAt $SomeStartAtObj -EndAt $SomeEndAtObj -License $SomeLicenseObj -IsPublic $SomeIsPublicObj -IsPublicToAuthUsers $SomeIsPublicToAuthUsersObj -PublicSyllabus $SomePublicSyllabusObj -PublicSyllabusToAuth $SomePublicSyllabusToAuthObj -PublicDescription $SomePublicDescriptionObj -AllowStudentWikiEdits $SomeAllowStudentWikiEditsObj -AllowWikiComments $SomeAllowWikiCommentsObj -AllowStudentForumAttachments $SomeAllowStudentForumAttachmentsObj -OpenEnrollment $SomeOpenEnrollmentObj -SelfEnrollment $SomeSelfEnrollmentObj -RestrictEnrollmentsToCourseDates $SomeRestrictEnrollmentsToCourseDatesObj -TermId $SomeTermIdObj -SisCourseId $SomeSisCourseIdObj -IntegrationId $SomeIntegrationIdObj -HideFinalGrades $SomeHideFinalGradesObj -ApplyAssignmentGroupWeights $SomeApplyAssignmentGroupWeightsObj -TimeZone $SomeTimeZoneObj -offer $SomeofferObj -enroll_me $Someenroll_meObj -SyllabusBody $SomeSyllabusBodyObj -GradingStandardId $SomeGradingStandardIdObj -CourseFormat $SomeCourseFormatObj -enable_sis_reactivation $Someenable_sis_reactivationObj
#>
function Post-CanvasAccountsCourses {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The name of the course. If omitted, the course will be named âUnnamed Course.â
        [Parameter(Mandatory=$false)]
        $Name,

        # The course code for the course.
        [Parameter(Mandatory=$false)]
        $CourseCode,

        # Course start date in ISO8601 format, e.g. 2011-01-01T01:00Z
        [Parameter(Mandatory=$false)]
        $StartAt,

        # Course end date in ISO8601 format. e.g. 2011-01-01T01:00Z
        [Parameter(Mandatory=$false)]
        $EndAt,

        # The name of the licensing. Should be one of the following abbreviations (a descriptive name is included in parenthesis for reference):
		#'private' (Private Copyrighted)
		#'cc_by_nc_nd' (CC Attribution Non-Commercial No Derivatives)
		#'cc_by_nc_sa' (CC Attribution Non-Commercial Share Alike)
		#'cc_by_nc' (CC Attribution Non-Commercial)
		#'cc_by_nd' (CC Attribution No Derivatives)
		#'cc_by_sa' (CC Attribution Share Alike)
		#'cc_by' (CC Attribution)
		#'public_domain' (Public Domain).
        [Parameter(Mandatory=$false)]
        $License,

        # Set to true if course is public to both authenticated and unauthenticated users.
        [Parameter(Mandatory=$false)]
        $IsPublic,

        # Set to true if course is public only to authenticated users.
        [Parameter(Mandatory=$false)]
        $IsPublicToAuthUsers,

        # Set to true to make the course syllabus public.
        [Parameter(Mandatory=$false)]
        $PublicSyllabus,

        # Set to true to make the course syllabus public for authenticated users.
        [Parameter(Mandatory=$false)]
        $PublicSyllabusToAuth,

        # A publicly visible description of the course.
        [Parameter(Mandatory=$false)]
        $PublicDescription,

        # If true, students will be able to modify the course wiki.
        [Parameter(Mandatory=$false)]
        $AllowStudentWikiEdits,

        # If true, course members will be able to comment on wiki pages.
        [Parameter(Mandatory=$false)]
        $AllowWikiComments,

        # If true, students can attach files to forum posts.
        [Parameter(Mandatory=$false)]
        $AllowStudentForumAttachments,

        # Set to true if the course is open enrollment.
        [Parameter(Mandatory=$false)]
        $OpenEnrollment,

        # Set to true if the course is self enrollment.
        [Parameter(Mandatory=$false)]
        $SelfEnrollment,

        # Set to true to restrict user enrollments to the start and end dates of the course.
        [Parameter(Mandatory=$false)]
        $RestrictEnrollmentsToCourseDates,

        # The unique ID of the term to create to course in.
        [Parameter(Mandatory=$false)]
        $TermId,

        # The unique SIS identifier.
        [Parameter(Mandatory=$false)]
        $SisCourseId,

        # The unique Integration identifier.
        [Parameter(Mandatory=$false)]
        $IntegrationId,

        # If this option is set to true, the totals in student grades summary will be hidden.
        [Parameter(Mandatory=$false)]
        $HideFinalGrades,

        # Set to true to weight final grade based on assignment groups percentages.
        [Parameter(Mandatory=$false)]
        $ApplyAssignmentGroupWeights,

        # The time zone for the course. Allowed time zones are IANA time zones or friendlier Ruby on Rails time zones.
        [Parameter(Mandatory=$false)]
        $TimeZone,

        # If this option is set to true, the course will be available to students immediately.
        [Parameter(Mandatory=$false)]
        $offer,

        # Set to true to enroll the current user as the teacher.
        [Parameter(Mandatory=$false)]
        $enroll_me,

        # The syllabus body for the course
        [Parameter(Mandatory=$false)]
        $SyllabusBody,

        # The grading standard id to set for the course. If no value is provided for this argument the current grading_standard will be un-set from this course.
        [Parameter(Mandatory=$false)]
        $GradingStandardId,

        # Optional. Specifies the format of the course. (Should be 'on_campus', 'online', or 'blended')
        [Parameter(Mandatory=$false)]
        $CourseFormat,

        # When true, will first try to re-activate a deleted course with matching sis_course_id if possible.
        [Parameter(Mandatory=$false)]
        $enable_sis_reactivation
	)

    $uri = "/api/v1/accounts/{0}/courses" -f $AccountId 

	$Body = @{}

	if ($Name) {$Body["course[name]"] = $Name}

	if ($CourseCode) {$Body["course[course_code]"] = $CourseCode}

	if ($StartAt) {$Body["course[start_at]"] = $StartAt}

	if ($EndAt) {$Body["course[end_at]"] = $EndAt}

	if ($License) {$Body["course[license]"] = $License}

	if ($IsPublic) {$Body["course[is_public]"] = $IsPublic}

	if ($IsPublicToAuthUsers) {$Body["course[is_public_to_auth_users]"] = $IsPublicToAuthUsers}

	if ($PublicSyllabus) {$Body["course[public_syllabus]"] = $PublicSyllabus}

	if ($PublicSyllabusToAuth) {$Body["course[public_syllabus_to_auth]"] = $PublicSyllabusToAuth}

	if ($PublicDescription) {$Body["course[public_description]"] = $PublicDescription}

	if ($AllowStudentWikiEdits) {$Body["course[allow_student_wiki_edits]"] = $AllowStudentWikiEdits}

	if ($AllowWikiComments) {$Body["course[allow_wiki_comments]"] = $AllowWikiComments}

	if ($AllowStudentForumAttachments) {$Body["course[allow_student_forum_attachments]"] = $AllowStudentForumAttachments}

	if ($OpenEnrollment) {$Body["course[open_enrollment]"] = $OpenEnrollment}

	if ($SelfEnrollment) {$Body["course[self_enrollment]"] = $SelfEnrollment}

	if ($RestrictEnrollmentsToCourseDates) {$Body["course[restrict_enrollments_to_course_dates]"] = $RestrictEnrollmentsToCourseDates}

	if ($TermId) {$Body["course[term_id]"] = $TermId}

	if ($SisCourseId) {$Body["course[sis_course_id]"] = $SisCourseId}

	if ($IntegrationId) {$Body["course[integration_id]"] = $IntegrationId}

	if ($HideFinalGrades) {$Body["course[hide_final_grades]"] = $HideFinalGrades}

	if ($ApplyAssignmentGroupWeights) {$Body["course[apply_assignment_group_weights]"] = $ApplyAssignmentGroupWeights}

	if ($TimeZone) {$Body["course[time_zone]"] = $TimeZone}

	if ($offer) {$Body["offer"] = $offer}

	if ($enroll_me) {$Body["enroll_me"] = $enroll_me}

	if ($SyllabusBody) {$Body["course[syllabus_body]"] = $SyllabusBody}

	if ($GradingStandardId) {$Body["course[grading_standard_id]"] = $GradingStandardId}

	if ($CourseFormat) {$Body["course[course_format]"] = $CourseFormat}

	if ($enable_sis_reactivation) {$Body["enable_sis_reactivation"] = $enable_sis_reactivation}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Upload a file 
.DESCRIPTION
   Upload a file to the course. This API endpoint is the first step in uploading a file to a course. See the File Upload Documentation for details on the file upload workflow. Only those with the âManage Filesâ permission on a course can upload files to the course. By default, this is Teachers, TAs and Designers.
.EXAMPLE
   PS C:> Post-CanvasCoursesFiles -CourseId $SomeCourseIdObj
#>
function Post-CanvasCoursesFiles {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/files" -f $CourseId 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   List students 
.DESCRIPTION
   Returns the list of students enrolled in this course. DEPRECATED: Please use the course users endpoint and pass âstudentâ as the enrollment_type.
.EXAMPLE
   PS C:> Get-CanvasCoursesStudents -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesStudents {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/students" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List users in course 
.DESCRIPTION
   Returns the list of users in this course. And optionally the user's enrollments in the course.
.EXAMPLE
   PS C:> Get-CanvasCoursesUsers -CourseId $SomeCourseIdObj -search_term $Somesearch_termObj -EnrollmentType $SomeEnrollmentTypeObj -enrollment_role $Someenrollment_roleObj -enrollment_role_id $Someenrollment_role_idObj -Include $SomeIncludeObj -user_id $Someuser_idObj -UserIds $SomeUserIdsObj -EnrollmentState $SomeEnrollmentStateObj
#>
function Get-CanvasCoursesUsers {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The partial name or full ID of the users to match and return in the results list.
        [Parameter(Mandatory=$false)]
        $search_term,

        # When set, only return users where the user is enrolled as this type. âstudent_viewâ implies include[]=test_student. This argument is ignored if enrollment_role is given.
		#Allowed values: teacher, student, student_view, ta, observer, designer 
        [Parameter(Mandatory=$false)]
        $EnrollmentType,

        # Deprecated When set, only return users enrolled with the specified course-level role. This can be a role created with the Add Role API or a base role type of 'StudentEnrollment', 'TeacherEnrollment', 'TaEnrollment', 'ObserverEnrollment', or 'DesignerEnrollment'.
        [Parameter(Mandatory=$false)]
        $enrollment_role,

        # When set, only return courses where the user is enrolled with the specified course-level role. This can be a role created with the Add Role API or a built_in role id with type 'StudentEnrollment', 'TeacherEnrollment', 'TaEnrollment', 'ObserverEnrollment', or 'DesignerEnrollment'.
        [Parameter(Mandatory=$false)]
        $enrollment_role_id,

        # âemailâ: Optional user email.
		#âenrollmentsâ:
		#Optionally include with each Course the user's current and invited enrollments. If the user is enrolled as a student, and the account has permission to manage or view all grades, each enrollment will include a 'grades' key with 'current_score', 'final_score', 'current_grade' and 'final_grade' values.
		#âlockedâ: Optionally include whether an enrollment is locked.
		#âavatar_urlâ: Optionally include avatar_url.
		#âbioâ: Optionally include each user's bio.
		#âtest_studentâ: Optionally include the course's Test Student,
		#if present. Default is to not include Test Student.
		#âcustom_linksâ: Optionally include plugin-supplied custom links for each student,
		#such as analytics information
		#Allowed values: email, enrollments, locked, avatar_url, test_student, bio, custom_links 
        [Parameter(Mandatory=$false)]
        $Include,

        # If this parameter is given and it corresponds to a user in the course, the page parameter will be ignored and the page containing the specified user will be returned instead.
        [Parameter(Mandatory=$false)]
        $user_id,

        # If included, the course users set will only include users with IDs specified by the param. Note: this will not work in conjunction with the âuser_idâ argument but multiple user_ids can be included.
        [Parameter(Mandatory=$false)]
        $UserIds,

        # When set, only return users where the enrollment workflow state is of one of the given types. âactiveâ and âinvitedâ enrollments are returned by default.
		#Allowed values: active, invited, rejected, completed, inactive 
        [Parameter(Mandatory=$false)]
        $EnrollmentState
	)

    $uri = "/api/v1/courses/{0}/users" -f $CourseId 

	$Body = @{}

	if ($search_term) {$Body["search_term"] = $search_term}

	if ($EnrollmentType) {$Body["enrollment_type[]"] = $EnrollmentType}

	if ($enrollment_role) {$Body["enrollment_role"] = $enrollment_role}

	if ($enrollment_role_id) {$Body["enrollment_role_id"] = $enrollment_role_id}

	if ($Include) {$Body["include[]"] = $Include}

	if ($user_id) {$Body["user_id"] = $user_id}

	if ($UserIds) {$Body["user_ids[]"] = $UserIds}

	if ($EnrollmentState) {$Body["enrollment_state[]"] = $EnrollmentState}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List recently logged in students 
.DESCRIPTION
   Returns the list of users in this course, ordered by how recently they have logged in. The records include the 'last_login' field which contains a timestamp of the last time that user logged into canvas. The querying user must have the 'View usage reports' permission.
.EXAMPLE
   PS C:> Get-CanvasCoursesRecentStudents -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesRecentStudents {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/recent_students" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get single user 
.DESCRIPTION
   Return information on a single user. Accepts the same include[] parameters as the :users: action, and returns a single user with the same fields as that action.
.EXAMPLE
   PS C:> Get-CanvasCoursesUsers -CourseId $SomeCourseIdObj -Id $SomeIdObj
#>
function Get-CanvasCoursesUsers {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/users/{1}" -f $CourseId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Preview processed html 
.DESCRIPTION
   Preview html content processed for this course
.EXAMPLE
   PS C:> Post-CanvasCoursesPreviewHtml -CourseId $SomeCourseIdObj -html $SomehtmlObj
#>
function Post-CanvasCoursesPreviewHtml {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The html content to process
        [Parameter(Mandatory=$false)]
        $html
	)

    $uri = "/api/v1/courses/{0}/preview_html" -f $CourseId 

	$Body = @{}

	if ($html) {$Body["html"] = $html}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Course activity stream 
.DESCRIPTION
   Returns the current user's course-specific activity stream, paginated. For full documentation, see the API documentation for the user activity stream, in the user api.
.EXAMPLE
   PS C:> Get-CanvasCoursesActivityStream -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesActivityStream {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/activity_stream" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Course activity stream summary 
.DESCRIPTION
   Returns a summary of the current user's course-specific activity stream. For full documentation, see the API documentation for the user activity stream summary, in the user api.
.EXAMPLE
   PS C:> Get-CanvasCoursesActivityStreamSummary -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesActivityStreamSummary {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/activity_stream/summary" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Course TODO items 
.DESCRIPTION
   Returns the current user's course-specific todo items. For full documentation, see the API documentation for the user todo items, in the user api.
.EXAMPLE
   PS C:> Get-CanvasCoursesTodo -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesTodo {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/todo" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Conclude a course 
.DESCRIPTION
   Delete or conclude an existing course
.EXAMPLE
   PS C:> Delete-CanvasCourses -Id $SomeIdObj -event $SomeeventObj
#>
function Delete-CanvasCourses {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The action to take on the course.
		#Allowed values: delete, conclude 
        [Parameter(Mandatory=$true)]
        $event
	)

    $uri = "/api/v1/courses/{0}" -f $Id 

	$Body = @{}

	$Body["event"] = $event

    return Get-CanvasApiResult $uri -Method DELETE -RequestParameters $Body
}


<#
.Synopsis
   Get course settings 
.DESCRIPTION
   Returns some of a course's settings.
.EXAMPLE
   PS C:> Get-CanvasCoursesSettings -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesSettings {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/settings" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Update course settings 
.DESCRIPTION
   Can update the following course settings:
.EXAMPLE
   PS C:> Put-CanvasCoursesSettings -CourseId $SomeCourseIdObj -allow_student_discussion_topics $Someallow_student_discussion_topicsObj -allow_student_forum_attachments $Someallow_student_forum_attachmentsObj -allow_student_discussion_editing $Someallow_student_discussion_editingObj -allow_student_organized_groups $Someallow_student_organized_groupsObj -hide_final_grades $Somehide_final_gradesObj -hide_distribution_graphs $Somehide_distribution_graphsObj -lock_all_announcements $Somelock_all_announcementsObj -restrict_student_past_view $Somerestrict_student_past_viewObj -restrict_student_future_view $Somerestrict_student_future_viewObj -show_announcements_on_home_page $Someshow_announcements_on_home_pageObj -home_page_announcement_limit $Somehome_page_announcement_limitObj
#>
function Put-CanvasCoursesSettings {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # Let students create discussion topics
        [Parameter(Mandatory=$false)]
        $allow_student_discussion_topics,

        # Let students attach files to discussions
        [Parameter(Mandatory=$false)]
        $allow_student_forum_attachments,

        # Let students edit or delete their own discussion posts
        [Parameter(Mandatory=$false)]
        $allow_student_discussion_editing,

        # Let students organize their own groups
        [Parameter(Mandatory=$false)]
        $allow_student_organized_groups,

        # Hide totals in student grades summary
        [Parameter(Mandatory=$false)]
        $hide_final_grades,

        # Hide grade distribution graphs from students
        [Parameter(Mandatory=$false)]
        $hide_distribution_graphs,

        # Disable comments on announcements
        [Parameter(Mandatory=$false)]
        $lock_all_announcements,

        # Restrict students from viewing courses after end date
        [Parameter(Mandatory=$false)]
        $restrict_student_past_view,

        # Restrict students from viewing courses before start date
        [Parameter(Mandatory=$false)]
        $restrict_student_future_view,

        # Show the most recent announcements on the Course home page (if a Wiki, defaults to five announcements, configurable via home_page_announcement_limit)
        [Parameter(Mandatory=$false)]
        $show_announcements_on_home_page,

        # Limit the number of announcements on the home page if enabled via show_announcements_on_home_page
        [Parameter(Mandatory=$false)]
        $home_page_announcement_limit
	)

    $uri = "/api/v1/courses/{0}/settings" -f $CourseId 

	$Body = @{}

	if ($allow_student_discussion_topics) {$Body["allow_student_discussion_topics"] = $allow_student_discussion_topics}

	if ($allow_student_forum_attachments) {$Body["allow_student_forum_attachments"] = $allow_student_forum_attachments}

	if ($allow_student_discussion_editing) {$Body["allow_student_discussion_editing"] = $allow_student_discussion_editing}

	if ($allow_student_organized_groups) {$Body["allow_student_organized_groups"] = $allow_student_organized_groups}

	if ($hide_final_grades) {$Body["hide_final_grades"] = $hide_final_grades}

	if ($hide_distribution_graphs) {$Body["hide_distribution_graphs"] = $hide_distribution_graphs}

	if ($lock_all_announcements) {$Body["lock_all_announcements"] = $lock_all_announcements}

	if ($restrict_student_past_view) {$Body["restrict_student_past_view"] = $restrict_student_past_view}

	if ($restrict_student_future_view) {$Body["restrict_student_future_view"] = $restrict_student_future_view}

	if ($show_announcements_on_home_page) {$Body["show_announcements_on_home_page"] = $show_announcements_on_home_page}

	if ($home_page_announcement_limit) {$Body["home_page_announcement_limit"] = $home_page_announcement_limit}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Get a single course 
.DESCRIPTION
   Return information on a single course. Accepts the same include[] parameters as the list action plus:
.EXAMPLE
   PS C:> Get-CanvasCourses -Id $SomeIdObj -Include $SomeIncludeObj
#>
function Get-CanvasCourses {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # âall_coursesâ: Also search recently deleted courses.
		#âpermissionsâ: Include permissions the current user has for the course.
		#âobserved_usersâ: include observed users in the enrollments
		#Allowed values: needs_grading_count, syllabus_body, public_description, total_scores, current_grading_period_scores, term, course_progress, sections, storage_quota_used_mb, total_students, passback_status, favorites, teachers, observed_users, all_courses, permissions, observed_users 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/courses/{0}" -f $Id 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Update a course 
.DESCRIPTION
   Update an existing course. Arguments are the same as Courses#create, with a few exceptions (enroll_me). If a user has content management rights, but not full course editing rights, the only attribute editable through this endpoint will be âsyllabus_bodyâ
.EXAMPLE
   PS C:> Put-CanvasCourses -Id $SomeIdObj -AccountId $SomeAccountIdObj -Name $SomeNameObj -CourseCode $SomeCourseCodeObj -StartAt $SomeStartAtObj -EndAt $SomeEndAtObj -License $SomeLicenseObj -IsPublic $SomeIsPublicObj -IsPublicToAuthUsers $SomeIsPublicToAuthUsersObj -PublicSyllabus $SomePublicSyllabusObj -PublicSyllabusToAuth $SomePublicSyllabusToAuthObj -PublicDescription $SomePublicDescriptionObj -AllowStudentWikiEdits $SomeAllowStudentWikiEditsObj -AllowWikiComments $SomeAllowWikiCommentsObj -AllowStudentForumAttachments $SomeAllowStudentForumAttachmentsObj -OpenEnrollment $SomeOpenEnrollmentObj -SelfEnrollment $SomeSelfEnrollmentObj -RestrictEnrollmentsToCourseDates $SomeRestrictEnrollmentsToCourseDatesObj -TermId $SomeTermIdObj -SisCourseId $SomeSisCourseIdObj -IntegrationId $SomeIntegrationIdObj -HideFinalGrades $SomeHideFinalGradesObj -TimeZone $SomeTimeZoneObj -ApplyAssignmentGroupWeights $SomeApplyAssignmentGroupWeightsObj -StorageQuotaMb $SomeStorageQuotaMbObj -offer $SomeofferObj -Event $SomeEventObj -SyllabusBody $SomeSyllabusBodyObj -GradingStandardId $SomeGradingStandardIdObj -CourseFormat $SomeCourseFormatObj -ImageId $SomeImageIdObj -ImageUrl $SomeImageUrlObj -RemoveImage $SomeRemoveImageObj
#>
function Put-CanvasCourses {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The unique ID of the account to move the course to.
        [Parameter(Mandatory=$false)]
        $AccountId,

        # The name of the course. If omitted, the course will be named âUnnamed Course.â
        [Parameter(Mandatory=$false)]
        $Name,

        # The course code for the course.
        [Parameter(Mandatory=$false)]
        $CourseCode,

        # Course start date in ISO8601 format, e.g. 2011-01-01T01:00Z
        [Parameter(Mandatory=$false)]
        $StartAt,

        # Course end date in ISO8601 format. e.g. 2011-01-01T01:00Z
        [Parameter(Mandatory=$false)]
        $EndAt,

        # The name of the licensing. Should be one of the following abbreviations (a descriptive name is included in parenthesis for reference):
		#'private' (Private Copyrighted)
		#'cc_by_nc_nd' (CC Attribution Non-Commercial No Derivatives)
		#'cc_by_nc_sa' (CC Attribution Non-Commercial Share Alike)
		#'cc_by_nc' (CC Attribution Non-Commercial)
		#'cc_by_nd' (CC Attribution No Derivatives)
		#'cc_by_sa' (CC Attribution Share Alike)
		#'cc_by' (CC Attribution)
		#'public_domain' (Public Domain).
        [Parameter(Mandatory=$false)]
        $License,

        # Set to true if course is public to both authenticated and unauthenticated users.
        [Parameter(Mandatory=$false)]
        $IsPublic,

        # Set to true if course is public only to authenticated users.
        [Parameter(Mandatory=$false)]
        $IsPublicToAuthUsers,

        # Set to true to make the course syllabus public.
        [Parameter(Mandatory=$false)]
        $PublicSyllabus,

        # Set to true to make the course syllabus to public for authenticated users.
        [Parameter(Mandatory=$false)]
        $PublicSyllabusToAuth,

        # A publicly visible description of the course.
        [Parameter(Mandatory=$false)]
        $PublicDescription,

        # If true, students will be able to modify the course wiki.
        [Parameter(Mandatory=$false)]
        $AllowStudentWikiEdits,

        # If true, course members will be able to comment on wiki pages.
        [Parameter(Mandatory=$false)]
        $AllowWikiComments,

        # If true, students can attach files to forum posts.
        [Parameter(Mandatory=$false)]
        $AllowStudentForumAttachments,

        # Set to true if the course is open enrollment.
        [Parameter(Mandatory=$false)]
        $OpenEnrollment,

        # Set to true if the course is self enrollment.
        [Parameter(Mandatory=$false)]
        $SelfEnrollment,

        # Set to true to restrict user enrollments to the start and end dates of the course.
        [Parameter(Mandatory=$false)]
        $RestrictEnrollmentsToCourseDates,

        # The unique ID of the term to create to course in.
        [Parameter(Mandatory=$false)]
        $TermId,

        # The unique SIS identifier.
        [Parameter(Mandatory=$false)]
        $SisCourseId,

        # The unique Integration identifier.
        [Parameter(Mandatory=$false)]
        $IntegrationId,

        # If this option is set to true, the totals in student grades summary will be hidden.
        [Parameter(Mandatory=$false)]
        $HideFinalGrades,

        # The time zone for the course. Allowed time zones are IANA time zones or friendlier Ruby on Rails time zones.
        [Parameter(Mandatory=$false)]
        $TimeZone,

        # Set to true to weight final grade based on assignment groups percentages.
        [Parameter(Mandatory=$false)]
        $ApplyAssignmentGroupWeights,

        # Set the storage quota for the course, in megabytes. The caller must have the âManage storage quotasâ account permission.
        [Parameter(Mandatory=$false)]
        $StorageQuotaMb,

        # If this option is set to true, the course will be available to students immediately.
        [Parameter(Mandatory=$false)]
        $offer,

        # The action to take on each course.
		#'claim' makes a course no longer visible to students. This action is also called âunpublishâ on the web site. A course cannot be unpublished if students have received graded submissions.
		#'offer' makes a course visible to students. This action is also called âpublishâ on the web site.
		#'conclude' prevents future enrollments and makes a course read-only for all participants. The course still appears in prior-enrollment lists.
		#'delete' completely removes the course from the web site (including course menus and prior-enrollment lists). All enrollments are deleted. Course content may be physically deleted at a future date.
		#'undelete' attempts to recover a course that has been deleted. (Recovery is not guaranteed; please conclude rather than delete a course if there is any possibility the course will be used again.) The recovered course will be unpublished. Deleted enrollments will not be recovered.
		#Allowed values: claim, offer, conclude, delete, undelete 
        [Parameter(Mandatory=$false)]
        $Event,

        # The syllabus body for the course
        [Parameter(Mandatory=$false)]
        $SyllabusBody,

        # The grading standard id to set for the course. If no value is provided for this argument the current grading_standard will be un-set from this course.
        [Parameter(Mandatory=$false)]
        $GradingStandardId,

        # Optional. Specifies the format of the course. (Should be either 'on_campus' or 'online')
        [Parameter(Mandatory=$false)]
        $CourseFormat,

        # This is a file ID corresponding to an image file in the course that will be used as the course image. This will clear the course's image_url setting if set. If you attempt to provide image_url and image_id in a request it will fail.
        [Parameter(Mandatory=$false)]
        $ImageId,

        # This is a URL to an image to be used as the course image. This will clear the course's image_id setting if set. If you attempt to provide image_url and image_id in a request it will fail.
        [Parameter(Mandatory=$false)]
        $ImageUrl,

        # If this option is set to true, the course image url and course image ID are both set to nil
        [Parameter(Mandatory=$false)]
        $RemoveImage
	)

    $uri = "/api/v1/courses/{0}" -f $Id 

	$Body = @{}

	if ($AccountId) {$Body["course[account_id]"] = $AccountId}

	if ($Name) {$Body["course[name]"] = $Name}

	if ($CourseCode) {$Body["course[course_code]"] = $CourseCode}

	if ($StartAt) {$Body["course[start_at]"] = $StartAt}

	if ($EndAt) {$Body["course[end_at]"] = $EndAt}

	if ($License) {$Body["course[license]"] = $License}

	if ($IsPublic) {$Body["course[is_public]"] = $IsPublic}

	if ($IsPublicToAuthUsers) {$Body["course[is_public_to_auth_users]"] = $IsPublicToAuthUsers}

	if ($PublicSyllabus) {$Body["course[public_syllabus]"] = $PublicSyllabus}

	if ($PublicSyllabusToAuth) {$Body["course[public_syllabus_to_auth]"] = $PublicSyllabusToAuth}

	if ($PublicDescription) {$Body["course[public_description]"] = $PublicDescription}

	if ($AllowStudentWikiEdits) {$Body["course[allow_student_wiki_edits]"] = $AllowStudentWikiEdits}

	if ($AllowWikiComments) {$Body["course[allow_wiki_comments]"] = $AllowWikiComments}

	if ($AllowStudentForumAttachments) {$Body["course[allow_student_forum_attachments]"] = $AllowStudentForumAttachments}

	if ($OpenEnrollment) {$Body["course[open_enrollment]"] = $OpenEnrollment}

	if ($SelfEnrollment) {$Body["course[self_enrollment]"] = $SelfEnrollment}

	if ($RestrictEnrollmentsToCourseDates) {$Body["course[restrict_enrollments_to_course_dates]"] = $RestrictEnrollmentsToCourseDates}

	if ($TermId) {$Body["course[term_id]"] = $TermId}

	if ($SisCourseId) {$Body["course[sis_course_id]"] = $SisCourseId}

	if ($IntegrationId) {$Body["course[integration_id]"] = $IntegrationId}

	if ($HideFinalGrades) {$Body["course[hide_final_grades]"] = $HideFinalGrades}

	if ($TimeZone) {$Body["course[time_zone]"] = $TimeZone}

	if ($ApplyAssignmentGroupWeights) {$Body["course[apply_assignment_group_weights]"] = $ApplyAssignmentGroupWeights}

	if ($StorageQuotaMb) {$Body["course[storage_quota_mb]"] = $StorageQuotaMb}

	if ($offer) {$Body["offer"] = $offer}

	if ($Event) {$Body["course[event]"] = $Event}

	if ($SyllabusBody) {$Body["course[syllabus_body]"] = $SyllabusBody}

	if ($GradingStandardId) {$Body["course[grading_standard_id]"] = $GradingStandardId}

	if ($CourseFormat) {$Body["course[course_format]"] = $CourseFormat}

	if ($ImageId) {$Body["course[image_id]"] = $ImageId}

	if ($ImageUrl) {$Body["course[image_url]"] = $ImageUrl}

	if ($RemoveImage) {$Body["course[remove_image]"] = $RemoveImage}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Update courses 
.DESCRIPTION
   Update multiple courses in an account. Operates asynchronously; use the progress endpoint to query the status of an operation. The action to take on each course. Must be one of 'offer', 'conclude', 'delete', or 'undelete'.
.EXAMPLE
   PS C:> Put-CanvasAccountsCourses -AccountId $SomeAccountIdObj -CourseIds $SomeCourseIdsObj -event $SomeeventObj
#>
function Put-CanvasAccountsCourses {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # List of ids of courses to update. At most 500 courses may be updated in one call.
        [Parameter(Mandatory=$true)]
        $CourseIds,

        # no description
		#Allowed values: offer, conclude, delete, undelete 
        [Parameter(Mandatory=$true)]
        $event
	)

    $uri = "/api/v1/accounts/{0}/courses" -f $AccountId 

	$Body = @{}

	$Body["course_ids[]"] = $CourseIds

	$Body["event"] = $event

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Reset a course 
.DESCRIPTION
   Deletes the current course, and creates a new equivalent course with no content, but all sections and users moved over.
.EXAMPLE
   PS C:> Post-CanvasCoursesResetContent -CourseId $SomeCourseIdObj
#>
function Post-CanvasCoursesResetContent {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/reset_content" -f $CourseId 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   Get effective due dates 
.DESCRIPTION
   For each assignment in the course, returns each assigned student's ID and their corresponding due date along with some Multiple Grading Periods data. Returns a collection with keys representing assignment IDs and values as a collection containing keys representing student IDs and values representing the student's effective due_at, the grading_period_id of which the due_at falls in, and whether or not the grading period is closed (in_closed_grading_period) The list of assignment IDs for which effective student due dates are requested. If not provided, all assignments in the course will be used.
.EXAMPLE
   PS C:> Get-CanvasCoursesEffectiveDueDates -CourseId $SomeCourseIdObj -AssignmentIds $SomeAssignmentIdsObj
#>
function Get-CanvasCoursesEffectiveDueDates {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # no description
        [Parameter(Mandatory=$false)]
        $AssignmentIds
	)

    $uri = "/api/v1/courses/{0}/effective_due_dates" -f $CourseId 

	$Body = @{}

	if ($AssignmentIds) {$Body["assignment_ids[]"] = $AssignmentIds}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Permissions 
.DESCRIPTION
   Returns permission information for provided course & current_user
.EXAMPLE
   PS C:> Get-CanvasCoursesPermissions -CourseId $SomeCourseIdObj -Permissions $SomePermissionsObj
#>
function Get-CanvasCoursesPermissions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # List of permissions to check against authenticated user
        [Parameter(Mandatory=$false)]
        $Permissions
	)

    $uri = "/api/v1/courses/{0}/permissions" -f $CourseId 

	$Body = @{}

	if ($Permissions) {$Body["permissions[]"] = $Permissions}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get course copy status 
.DESCRIPTION
   DEPRECATED: Please use the Content Migrations API Retrieve the status of a course copy
.EXAMPLE
   PS C:> Get-CanvasCoursesCourseCopy -CourseId $SomeCourseIdObj -Id $SomeIdObj
#>
function Get-CanvasCoursesCourseCopy {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/course_copy/{1}" -f $CourseId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Copy course content 
.DESCRIPTION
   DEPRECATED: Please use the Content Migrations API Copies content from one course into another. The default is to copy all course content. You can control specific types to copy by using either the 'except' option or the 'only' option. The response is the same as the course copy status endpoint
.EXAMPLE
   PS C:> Post-CanvasCoursesCourseCopy -CourseId $SomeCourseIdObj -source_course $Somesource_courseObj -Except $SomeExceptObj -Only $SomeOnlyObj
#>
function Post-CanvasCoursesCourseCopy {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # ID or SIS-ID of the course to copy the content from
        [Parameter(Mandatory=$false)]
        $source_course,

        # A list of the course content types to exclude, all areas not listed will be copied.
		#Allowed values: course_settings, assignments, external_tools, files, topics, calendar_events, quizzes, wiki_pages, modules, outcomes 
        [Parameter(Mandatory=$false)]
        $Except,

        # A list of the course content types to copy, all areas not listed will not be copied.
		#Allowed values: course_settings, assignments, external_tools, files, topics, calendar_events, quizzes, wiki_pages, modules, outcomes 
        [Parameter(Mandatory=$false)]
        $Only
	)

    $uri = "/api/v1/courses/{0}/course_copy" -f $CourseId 

	$Body = @{}

	if ($source_course) {$Body["source_course"] = $source_course}

	if ($Except) {$Body["except[]"] = $Except}

	if ($Only) {$Body["only[]"] = $Only}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   List custom gradebook columns 
.DESCRIPTION
   List all custom gradebook columns for a course
.EXAMPLE
   PS C:> Get-CanvasCoursesCustomGradebookColumns -CourseId $SomeCourseIdObj -include_hidden $Someinclude_hiddenObj
#>
function Get-CanvasCoursesCustomGradebookColumns {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # Include hidden parameters (defaults to false)
        [Parameter(Mandatory=$false)]
        $include_hidden
	)

    $uri = "/api/v1/courses/{0}/custom_gradebook_columns" -f $CourseId 

	$Body = @{}

	if ($include_hidden) {$Body["include_hidden"] = $include_hidden}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create a custom gradebook column 
.DESCRIPTION
   Create a custom gradebook column
.EXAMPLE
   PS C:> Post-CanvasCoursesCustomGradebookColumns -CourseId $SomeCourseIdObj -Title $SomeTitleObj -Position $SomePositionObj -Hidden $SomeHiddenObj -TeacherNotes $SomeTeacherNotesObj
#>
function Post-CanvasCoursesCustomGradebookColumns {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # no description
        [Parameter(Mandatory=$true)]
        $Title,

        # The position of the column relative to other custom columns
        [Parameter(Mandatory=$false)]
        $Position,

        # Hidden columns are not displayed in the gradebook
        [Parameter(Mandatory=$false)]
        $Hidden,

        # Set this if the column is created by a teacher. The gradebook only supports one teacher_notes column.
        [Parameter(Mandatory=$false)]
        $TeacherNotes
	)

    $uri = "/api/v1/courses/{0}/custom_gradebook_columns" -f $CourseId 

	$Body = @{}

	$Body["column[title]"] = $Title

	if ($Position) {$Body["column[position]"] = $Position}

	if ($Hidden) {$Body["column[hidden]"] = $Hidden}

	if ($TeacherNotes) {$Body["column[teacher_notes]"] = $TeacherNotes}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Update a custom gradebook column 
.DESCRIPTION
   Accepts the same parameters as custom gradebook column creation
.EXAMPLE
   PS C:> Put-CanvasCoursesCustomGradebookColumns -CourseId $SomeCourseIdObj -Id $SomeIdObj
#>
function Put-CanvasCoursesCustomGradebookColumns {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/custom_gradebook_columns/{1}" -f $CourseId, $Id 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Delete a custom gradebook column 
.DESCRIPTION
   Permanently deletes a custom column and its associated data
.EXAMPLE
   PS C:> Delete-CanvasCoursesCustomGradebookColumns -CourseId $SomeCourseIdObj -Id $SomeIdObj
#>
function Delete-CanvasCoursesCustomGradebookColumns {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/custom_gradebook_columns/{1}" -f $CourseId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Reorder custom columns 
.DESCRIPTION
   Puts the given columns in the specified order 200 OK is returned if successful
.EXAMPLE
   PS C:> Post-CanvasCoursesCustomGradebookColumnsReorder -CourseId $SomeCourseIdObj -Order $SomeOrderObj
#>
function Post-CanvasCoursesCustomGradebookColumnsReorder {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # no description
        [Parameter(Mandatory=$true)]
        $Order
	)

    $uri = "/api/v1/courses/{0}/custom_gradebook_columns/reorder" -f $CourseId 

	$Body = @{}

	$Body["order[]"] = $Order

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   List entries for a column 
.DESCRIPTION
   This does not list entries for students without associated data.
.EXAMPLE
   PS C:> Get-CanvasCoursesCustomGradebookColumnsData -CourseId $SomeCourseIdObj -Id $SomeIdObj -include_hidden $Someinclude_hiddenObj
#>
function Get-CanvasCoursesCustomGradebookColumnsData {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # If true, hidden columns will be included in the result. If false or absent, only visible columns will be returned.
        [Parameter(Mandatory=$false)]
        $include_hidden
	)

    $uri = "/api/v1/courses/{0}/custom_gradebook_columns/{1}/data" -f $CourseId, $Id 

	$Body = @{}

	if ($include_hidden) {$Body["include_hidden"] = $include_hidden}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Update column data 
.DESCRIPTION
   Set the content of a custom column
.EXAMPLE
   PS C:> Put-CanvasCoursesCustomGradebookColumnsData -CourseId $SomeCourseIdObj -Id $SomeIdObj -UserId $SomeUserIdObj -Content $SomeContentObj
#>
function Put-CanvasCoursesCustomGradebookColumnsData {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # Column content. Setting this to blank will delete the datum object.
        [Parameter(Mandatory=$true)]
        $Content
	)

    $uri = "/api/v1/courses/{0}/custom_gradebook_columns/{1}/data/{2}" -f $CourseId, $Id, $UserId 

	$Body = @{}

	$Body["column_data[content]"] = $Content

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   List discussion topics 
.DESCRIPTION
   Returns the paginated list of discussion topics for this course or group.
.EXAMPLE
   PS C:> Get-CanvasCoursesDiscussionTopics -CourseId $SomeCourseIdObj -Include $SomeIncludeObj -order_by $Someorder_byObj -scope $SomescopeObj -only_announcements $Someonly_announcementsObj -search_term $Somesearch_termObj -exclude_context_module_locked_topics $Someexclude_context_module_locked_topicsObj
#>
function Get-CanvasCoursesDiscussionTopics {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # If âall_datesâ is passed, all dates associated with graded discussions' assignments will be included.
		#Allowed values: all_dates 
        [Parameter(Mandatory=$false)]
        $Include,

        # Determines the order of the discussion topic list. Defaults to âpositionâ.
		#Allowed values: position, recent_activity 
        [Parameter(Mandatory=$false)]
        $order_by,

        # Only return discussion topics in the given state(s). Defaults to including all topics. Filtering is done after pagination, so pages may be smaller than requested if topics are filtered. Can pass multiple states as comma separated string.
		#Allowed values: locked, unlocked, pinned, unpinned 
        [Parameter(Mandatory=$false)]
        $scope,

        # Return announcements instead of discussion topics. Defaults to false
        [Parameter(Mandatory=$false)]
        $only_announcements,

        # The partial title of the discussion topics to match and return.
        [Parameter(Mandatory=$false)]
        $search_term,

        # For students, exclude topics that are locked by module progression. Defaults to false.
        [Parameter(Mandatory=$false)]
        $exclude_context_module_locked_topics
	)

    $uri = "/api/v1/courses/{0}/discussion_topics" -f $CourseId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

	if ($order_by) {$Body["order_by"] = $order_by}

	if ($scope) {$Body["scope"] = $scope}

	if ($only_announcements) {$Body["only_announcements"] = $only_announcements}

	if ($search_term) {$Body["search_term"] = $search_term}

	if ($exclude_context_module_locked_topics) {$Body["exclude_context_module_locked_topics"] = $exclude_context_module_locked_topics}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create a new discussion topic 
.DESCRIPTION
   Create an new discussion topic for the course or group.
.EXAMPLE
   PS C:> Post-CanvasCoursesDiscussionTopics -CourseId $SomeCourseIdObj -title $SometitleObj -message $SomemessageObj -discussion_type $Somediscussion_typeObj -published $SomepublishedObj -delayed_post_at $Somedelayed_post_atObj -lock_at $Somelock_atObj -podcast_enabled $Somepodcast_enabledObj -podcast_has_student_posts $Somepodcast_has_student_postsObj -require_initial_post $Somerequire_initial_postObj -assignment $SomeassignmentObj -is_announcement $Someis_announcementObj -pinned $SomepinnedObj -position_after $Someposition_afterObj -group_category_id $Somegroup_category_idObj -allow_rating $Someallow_ratingObj -only_graders_can_rate $Someonly_graders_can_rateObj -sort_by_rating $Somesort_by_ratingObj -attachment $SomeattachmentObj
#>
function Post-CanvasCoursesDiscussionTopics {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # no description
        [Parameter(Mandatory=$false)]
        $title,

        # no description
        [Parameter(Mandatory=$false)]
        $message,

        # The type of discussion. Defaults to side_comment if not value is given. Accepted values are 'side_comment', for discussions that only allow one level of nested comments, and 'threaded' for fully threaded discussions.
		#Allowed values: side_comment, threaded 
        [Parameter(Mandatory=$false)]
        $discussion_type,

        # Whether this topic is published (true) or draft state (false). Only teachers and TAs have the ability to create draft state topics.
        [Parameter(Mandatory=$false)]
        $published,

        # If a timestamp is given, the topic will not be published until that time.
        [Parameter(Mandatory=$false)]
        $delayed_post_at,

        # If a timestamp is given, the topic will be scheduled to lock at the provided timestamp. If the timestamp is in the past, the topic will be locked.
        [Parameter(Mandatory=$false)]
        $lock_at,

        # If true, the topic will have an associated podcast feed.
        [Parameter(Mandatory=$false)]
        $podcast_enabled,

        # If true, the podcast will include posts from students as well. Implies podcast_enabled.
        [Parameter(Mandatory=$false)]
        $podcast_has_student_posts,

        # If true then a user may not respond to other replies until that user has made an initial reply. Defaults to false.
        [Parameter(Mandatory=$false)]
        $require_initial_post,

        # To create an assignment discussion, pass the assignment parameters as a sub-object. See the Create an Assignment API for the available parameters. The name parameter will be ignored, as it's taken from the discussion title. If you want to make a discussion that was an assignment NOT an assignment, pass set_assignment = false as part of the assignment object
        [Parameter(Mandatory=$false)]
        $assignment,

        # If true, this topic is an announcement. It will appear in the announcement's section rather than the discussions section. This requires announcment-posting permissions.
        [Parameter(Mandatory=$false)]
        $is_announcement,

        # If true, this topic will be listed in the âPinned Discussionâ section
        [Parameter(Mandatory=$false)]
        $pinned,

        # By default, discussions are sorted chronologically by creation date, you can pass the id of another topic to have this one show up after the other when they are listed.
        [Parameter(Mandatory=$false)]
        $position_after,

        # If present, the topic will become a group discussion assigned to the group.
        [Parameter(Mandatory=$false)]
        $group_category_id,

        # If true, users will be allowed to rate entries.
        [Parameter(Mandatory=$false)]
        $allow_rating,

        # If true, only graders will be allowed to rate entries.
        [Parameter(Mandatory=$false)]
        $only_graders_can_rate,

        # If true, entries will be sorted by rating.
        [Parameter(Mandatory=$false)]
        $sort_by_rating,

        # A multipart/form-data form-field-style attachment. Attachments larger than 1 kilobyte are subject to quota restrictions.
        [Parameter(Mandatory=$false)]
        $attachment
	)

    $uri = "/api/v1/courses/{0}/discussion_topics" -f $CourseId 

	$Body = @{}

	if ($title) {$Body["title"] = $title}

	if ($message) {$Body["message"] = $message}

	if ($discussion_type) {$Body["discussion_type"] = $discussion_type}

	if ($published) {$Body["published"] = $published}

	if ($delayed_post_at) {$Body["delayed_post_at"] = $delayed_post_at}

	if ($lock_at) {$Body["lock_at"] = $lock_at}

	if ($podcast_enabled) {$Body["podcast_enabled"] = $podcast_enabled}

	if ($podcast_has_student_posts) {$Body["podcast_has_student_posts"] = $podcast_has_student_posts}

	if ($require_initial_post) {$Body["require_initial_post"] = $require_initial_post}

	if ($assignment) {$Body["assignment"] = $assignment}

	if ($is_announcement) {$Body["is_announcement"] = $is_announcement}

	if ($pinned) {$Body["pinned"] = $pinned}

	if ($position_after) {$Body["position_after"] = $position_after}

	if ($group_category_id) {$Body["group_category_id"] = $group_category_id}

	if ($allow_rating) {$Body["allow_rating"] = $allow_rating}

	if ($only_graders_can_rate) {$Body["only_graders_can_rate"] = $only_graders_can_rate}

	if ($sort_by_rating) {$Body["sort_by_rating"] = $sort_by_rating}

	if ($attachment) {$Body["attachment"] = $attachment}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Update a topic 
.DESCRIPTION
   Update an existing discussion topic for the course or group.
.EXAMPLE
   PS C:> Put-CanvasCoursesDiscussionTopics -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj -title $SometitleObj -message $SomemessageObj -discussion_type $Somediscussion_typeObj -published $SomepublishedObj -delayed_post_at $Somedelayed_post_atObj -lock_at $Somelock_atObj -podcast_enabled $Somepodcast_enabledObj -podcast_has_student_posts $Somepodcast_has_student_postsObj -require_initial_post $Somerequire_initial_postObj -assignment $SomeassignmentObj -is_announcement $Someis_announcementObj -pinned $SomepinnedObj -position_after $Someposition_afterObj -group_category_id $Somegroup_category_idObj -allow_rating $Someallow_ratingObj -only_graders_can_rate $Someonly_graders_can_rateObj -sort_by_rating $Somesort_by_ratingObj
#>
function Put-CanvasCoursesDiscussionTopics {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId,

        # no description
        [Parameter(Mandatory=$false)]
        $title,

        # no description
        [Parameter(Mandatory=$false)]
        $message,

        # The type of discussion. Defaults to side_comment if not value is given. Accepted values are 'side_comment', for discussions that only allow one level of nested comments, and 'threaded' for fully threaded discussions.
		#Allowed values: side_comment, threaded 
        [Parameter(Mandatory=$false)]
        $discussion_type,

        # Whether this topic is published (true) or draft state (false). Only teachers and TAs have the ability to create draft state topics.
        [Parameter(Mandatory=$false)]
        $published,

        # If a timestamp is given, the topic will not be published until that time.
        [Parameter(Mandatory=$false)]
        $delayed_post_at,

        # If a timestamp is given, the topic will be scheduled to lock at the provided timestamp. If the timestamp is in the past, the topic will be locked.
        [Parameter(Mandatory=$false)]
        $lock_at,

        # If true, the topic will have an associated podcast feed.
        [Parameter(Mandatory=$false)]
        $podcast_enabled,

        # If true, the podcast will include posts from students as well. Implies podcast_enabled.
        [Parameter(Mandatory=$false)]
        $podcast_has_student_posts,

        # If true then a user may not respond to other replies until that user has made an initial reply. Defaults to false.
        [Parameter(Mandatory=$false)]
        $require_initial_post,

        # To create an assignment discussion, pass the assignment parameters as a sub-object. See the Create an Assignment API for the available parameters. The name parameter will be ignored, as it's taken from the discussion title. If you want to make a discussion that was an assignment NOT an assignment, pass set_assignment = false as part of the assignment object
        [Parameter(Mandatory=$false)]
        $assignment,

        # If true, this topic is an announcement. It will appear in the announcement's section rather than the discussions section. This requires announcment-posting permissions.
        [Parameter(Mandatory=$false)]
        $is_announcement,

        # If true, this topic will be listed in the âPinned Discussionâ section
        [Parameter(Mandatory=$false)]
        $pinned,

        # By default, discussions are sorted chronologically by creation date, you can pass the id of another topic to have this one show up after the other when they are listed.
        [Parameter(Mandatory=$false)]
        $position_after,

        # If present, the topic will become a group discussion assigned to the group.
        [Parameter(Mandatory=$false)]
        $group_category_id,

        # If true, users will be allowed to rate entries.
        [Parameter(Mandatory=$false)]
        $allow_rating,

        # If true, only graders will be allowed to rate entries.
        [Parameter(Mandatory=$false)]
        $only_graders_can_rate,

        # If true, entries will be sorted by rating.
        [Parameter(Mandatory=$false)]
        $sort_by_rating
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}" -f $CourseId, $TopicId 

	$Body = @{}

	if ($title) {$Body["title"] = $title}

	if ($message) {$Body["message"] = $message}

	if ($discussion_type) {$Body["discussion_type"] = $discussion_type}

	if ($published) {$Body["published"] = $published}

	if ($delayed_post_at) {$Body["delayed_post_at"] = $delayed_post_at}

	if ($lock_at) {$Body["lock_at"] = $lock_at}

	if ($podcast_enabled) {$Body["podcast_enabled"] = $podcast_enabled}

	if ($podcast_has_student_posts) {$Body["podcast_has_student_posts"] = $podcast_has_student_posts}

	if ($require_initial_post) {$Body["require_initial_post"] = $require_initial_post}

	if ($assignment) {$Body["assignment"] = $assignment}

	if ($is_announcement) {$Body["is_announcement"] = $is_announcement}

	if ($pinned) {$Body["pinned"] = $pinned}

	if ($position_after) {$Body["position_after"] = $position_after}

	if ($group_category_id) {$Body["group_category_id"] = $group_category_id}

	if ($allow_rating) {$Body["allow_rating"] = $allow_rating}

	if ($only_graders_can_rate) {$Body["only_graders_can_rate"] = $only_graders_can_rate}

	if ($sort_by_rating) {$Body["sort_by_rating"] = $sort_by_rating}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Delete a topic 
.DESCRIPTION
   Deletes the discussion topic. This will also delete the assignment, if it's an assignment discussion.
.EXAMPLE
   PS C:> Delete-CanvasCoursesDiscussionTopics -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj
#>
function Delete-CanvasCoursesDiscussionTopics {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}" -f $CourseId, $TopicId 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Reorder pinned topics 
.DESCRIPTION
   Puts the pinned discussion topics in the specified order. All pinned topics should be included.
.EXAMPLE
   PS C:> Post-CanvasCoursesDiscussionTopicsReorder -CourseId $SomeCourseIdObj -Order $SomeOrderObj
#>
function Post-CanvasCoursesDiscussionTopicsReorder {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The ids of the pinned discussion topics in the desired order. (For example, âorder=104,102,103â.)
        [Parameter(Mandatory=$true)]
        $Order
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/reorder" -f $CourseId 

	$Body = @{}

	$Body["order[]"] = $Order

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Update an entry 
.DESCRIPTION
   Update an existing discussion entry. The entry must have been created by the current user, or the current user must have admin rights to the discussion. If the edit is not allowed, a 401 will be returned.
.EXAMPLE
   PS C:> Put-CanvasCoursesDiscussionTopicsEntries -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj -Id $SomeIdObj -message $SomemessageObj
#>
function Put-CanvasCoursesDiscussionTopicsEntries {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The updated body of the entry.
        [Parameter(Mandatory=$false)]
        $message
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/entries/{2}" -f $CourseId, $TopicId, $Id 

	$Body = @{}

	if ($message) {$Body["message"] = $message}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Delete an entry 
.DESCRIPTION
   Delete a discussion entry. The entry must have been created by the current user, or the current user must have admin rights to the discussion. If the delete is not allowed, a 401 will be returned. The discussion will be marked deleted, and the user_id and message will be cleared out.
.EXAMPLE
   PS C:> Delete-CanvasCoursesDiscussionTopicsEntries -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj -Id $SomeIdObj
#>
function Delete-CanvasCoursesDiscussionTopicsEntries {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/entries/{2}" -f $CourseId, $TopicId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Get a single topic 
.DESCRIPTION
   Returns data on an individual discussion topic. See the List action for the response formatting.
.EXAMPLE
   PS C:> Get-CanvasCoursesDiscussionTopics -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj
#>
function Get-CanvasCoursesDiscussionTopics {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}" -f $CourseId, $TopicId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get the full topic 
.DESCRIPTION
   Return a cached structure of the discussion topic, containing all entries, their authors, and their message bodies. May require (depending on the topic) that the user has posted in the topic. If it is required, and the user has not posted, will respond with a 403 Forbidden status and the body 'require_initial_post'. In some rare situations, this cached structure may not be available yet. In that case, the server will respond with a 503 error, and the caller should try again soon. The response is an object containing the following keys:
.EXAMPLE
   PS C:> Get-CanvasCoursesDiscussionTopicsView -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj
#>
function Get-CanvasCoursesDiscussionTopicsView {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/view" -f $CourseId, $TopicId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Post an entry 
.DESCRIPTION
   Create a new entry in a discussion topic. Returns a json representation of the created entry (see documentation for 'entries' method) on success.
.EXAMPLE
   PS C:> Post-CanvasCoursesDiscussionTopicsEntries -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj -message $SomemessageObj -attachment $SomeattachmentObj
#>
function Post-CanvasCoursesDiscussionTopicsEntries {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId,

        # The body of the entry.
        [Parameter(Mandatory=$false)]
        $message,

        # a multipart/form-data form-field-style attachment. Attachments larger than 1 kilobyte are subject to quota restrictions.
        [Parameter(Mandatory=$false)]
        $attachment
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/entries" -f $CourseId, $TopicId 

	$Body = @{}

	if ($message) {$Body["message"] = $message}

	if ($attachment) {$Body["attachment"] = $attachment}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   List topic entries 
.DESCRIPTION
   Retrieve the (paginated) top-level entries in a discussion topic. May require (depending on the topic) that the user has posted in the topic. If it is required, and the user has not posted, will respond with a 403 Forbidden status and the body 'require_initial_post'. Will include the 10 most recent replies, if any, for each entry returned. If the topic is a root topic with children corresponding to groups of a group assignment, entries from those subtopics for which the user belongs to the corresponding group will be returned. Ordering of returned entries is newest-first by posting timestamp (reply activity is ignored).
.EXAMPLE
   PS C:> Get-CanvasCoursesDiscussionTopicsEntries -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj
#>
function Get-CanvasCoursesDiscussionTopicsEntries {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/entries" -f $CourseId, $TopicId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Post a reply 
.DESCRIPTION
   Add a reply to an entry in a discussion topic. Returns a json representation of the created reply (see documentation for 'replies' method) on success. May require (depending on the topic) that the user has posted in the topic. If it is required, and the user has not posted, will respond with a 403 Forbidden status and the body 'require_initial_post'.
.EXAMPLE
   PS C:> Post-CanvasCoursesDiscussionTopicsEntriesReplies -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj -EntryId $SomeEntryIdObj -message $SomemessageObj -attachment $SomeattachmentObj
#>
function Post-CanvasCoursesDiscussionTopicsEntriesReplies {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId,

        # The EntryId
        [Parameter(Mandatory=$true)]
        $EntryId,

        # The body of the entry.
        [Parameter(Mandatory=$false)]
        $message,

        # a multipart/form-data form-field-style attachment. Attachments larger than 1 kilobyte are subject to quota restrictions.
        [Parameter(Mandatory=$false)]
        $attachment
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/entries/{2}/replies" -f $CourseId, $TopicId, $EntryId 

	$Body = @{}

	if ($message) {$Body["message"] = $message}

	if ($attachment) {$Body["attachment"] = $attachment}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   List entry replies 
.DESCRIPTION
   Retrieve the (paginated) replies to a top-level entry in a discussion topic. May require (depending on the topic) that the user has posted in the topic. If it is required, and the user has not posted, will respond with a 403 Forbidden status and the body 'require_initial_post'. Ordering of returned entries is newest-first by creation timestamp.
.EXAMPLE
   PS C:> Get-CanvasCoursesDiscussionTopicsEntriesReplies -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj -EntryId $SomeEntryIdObj
#>
function Get-CanvasCoursesDiscussionTopicsEntriesReplies {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId,

        # The EntryId
        [Parameter(Mandatory=$true)]
        $EntryId
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/entries/{2}/replies" -f $CourseId, $TopicId, $EntryId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List entries 
.DESCRIPTION
   Retrieve a paginated list of discussion entries, given a list of ids. May require (depending on the topic) that the user has posted in the topic. If it is required, and the user has not posted, will respond with a 403 Forbidden status and the body 'require_initial_post'.
.EXAMPLE
   PS C:> Get-CanvasCoursesDiscussionTopicsEntryList -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj -Ids $SomeIdsObj
#>
function Get-CanvasCoursesDiscussionTopicsEntryList {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId,

        # A list of entry ids to retrieve. Entries will be returned in id order, smallest id first.
        [Parameter(Mandatory=$false)]
        $Ids
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/entry_list" -f $CourseId, $TopicId 

	$Body = @{}

	if ($Ids) {$Body["ids[]"] = $Ids}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Mark topic as read 
.DESCRIPTION
   Mark the initial text of the discussion topic as read. No request fields are necessary. On success, the response will be 204 No Content with an empty body.
.EXAMPLE
   PS C:> Put-CanvasCoursesDiscussionTopicsRead -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj
#>
function Put-CanvasCoursesDiscussionTopicsRead {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/read" -f $CourseId, $TopicId 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Mark topic as unread 
.DESCRIPTION
   Mark the initial text of the discussion topic as unread. No request fields are necessary. On success, the response will be 204 No Content with an empty body.
.EXAMPLE
   PS C:> Delete-CanvasCoursesDiscussionTopicsRead -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj
#>
function Delete-CanvasCoursesDiscussionTopicsRead {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/read" -f $CourseId, $TopicId 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Mark all entries as read 
.DESCRIPTION
   Mark the discussion topic and all its entries as read. No request fields are necessary. On success, the response will be 204 No Content with an empty body.
.EXAMPLE
   PS C:> Put-CanvasCoursesDiscussionTopicsReadAll -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj -forced_read_state $Someforced_read_stateObj
#>
function Put-CanvasCoursesDiscussionTopicsReadAll {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId,

        # A boolean value to set all of the entries' forced_read_state. No change is made if this argument is not specified.
        [Parameter(Mandatory=$false)]
        $forced_read_state
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/read_all" -f $CourseId, $TopicId 

	$Body = @{}

	if ($forced_read_state) {$Body["forced_read_state"] = $forced_read_state}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Mark all entries as unread 
.DESCRIPTION
   Mark the discussion topic and all its entries as unread. No request fields are necessary. On success, the response will be 204 No Content with an empty body.
.EXAMPLE
   PS C:> Delete-CanvasCoursesDiscussionTopicsReadAll -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj -forced_read_state $Someforced_read_stateObj
#>
function Delete-CanvasCoursesDiscussionTopicsReadAll {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId,

        # A boolean value to set all of the entries' forced_read_state. No change is made if this argument is not specified.
        [Parameter(Mandatory=$false)]
        $forced_read_state
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/read_all" -f $CourseId, $TopicId 

	$Body = @{}

	if ($forced_read_state) {$Body["forced_read_state"] = $forced_read_state}

    return Get-CanvasApiResult $uri -Method DELETE -RequestParameters $Body
}


<#
.Synopsis
   Mark entry as read 
.DESCRIPTION
   Mark a discussion entry as read. No request fields are necessary. On success, the response will be 204 No Content with an empty body.
.EXAMPLE
   PS C:> Put-CanvasCoursesDiscussionTopicsEntriesRead -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj -EntryId $SomeEntryIdObj -forced_read_state $Someforced_read_stateObj
#>
function Put-CanvasCoursesDiscussionTopicsEntriesRead {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId,

        # The EntryId
        [Parameter(Mandatory=$true)]
        $EntryId,

        # A boolean value to set the entry's forced_read_state. No change is made if this argument is not specified.
        [Parameter(Mandatory=$false)]
        $forced_read_state
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/entries/{2}/read" -f $CourseId, $TopicId, $EntryId 

	$Body = @{}

	if ($forced_read_state) {$Body["forced_read_state"] = $forced_read_state}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Mark entry as unread 
.DESCRIPTION
   Mark a discussion entry as unread. No request fields are necessary. On success, the response will be 204 No Content with an empty body.
.EXAMPLE
   PS C:> Delete-CanvasCoursesDiscussionTopicsEntriesRead -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj -EntryId $SomeEntryIdObj -forced_read_state $Someforced_read_stateObj
#>
function Delete-CanvasCoursesDiscussionTopicsEntriesRead {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId,

        # The EntryId
        [Parameter(Mandatory=$true)]
        $EntryId,

        # A boolean value to set the entry's forced_read_state. No change is made if this argument is not specified.
        [Parameter(Mandatory=$false)]
        $forced_read_state
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/entries/{2}/read" -f $CourseId, $TopicId, $EntryId 

	$Body = @{}

	if ($forced_read_state) {$Body["forced_read_state"] = $forced_read_state}

    return Get-CanvasApiResult $uri -Method DELETE -RequestParameters $Body
}


<#
.Synopsis
   Rate entry 
.DESCRIPTION
   Rate a discussion entry. On success, the response will be 204 No Content with an empty body.
.EXAMPLE
   PS C:> Post-CanvasCoursesDiscussionTopicsEntriesRating -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj -EntryId $SomeEntryIdObj -rating $SomeratingObj
#>
function Post-CanvasCoursesDiscussionTopicsEntriesRating {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId,

        # The EntryId
        [Parameter(Mandatory=$true)]
        $EntryId,

        # A rating to set on this entry. Only 0 and 1 are accepted.
        [Parameter(Mandatory=$false)]
        $rating
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/entries/{2}/rating" -f $CourseId, $TopicId, $EntryId 

	$Body = @{}

	if ($rating) {$Body["rating"] = $rating}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Subscribe to a topic 
.DESCRIPTION
   Subscribe to a topic to receive notifications about new entries On success, the response will be 204 No Content with an empty body
.EXAMPLE
   PS C:> Put-CanvasCoursesDiscussionTopicsSubscribed -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj
#>
function Put-CanvasCoursesDiscussionTopicsSubscribed {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/subscribed" -f $CourseId, $TopicId 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Unsubscribe from a topic 
.DESCRIPTION
   Unsubscribe from a topic to stop receiving notifications about new entries On success, the response will be 204 No Content with an empty body
.EXAMPLE
   PS C:> Delete-CanvasCoursesDiscussionTopicsSubscribed -CourseId $SomeCourseIdObj -TopicId $SomeTopicIdObj
#>
function Delete-CanvasCoursesDiscussionTopicsSubscribed {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TopicId
        [Parameter(Mandatory=$true)]
        $TopicId
	)

    $uri = "/api/v1/courses/{0}/discussion_topics/{1}/subscribed" -f $CourseId, $TopicId 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Create enrollment term 
.DESCRIPTION
   Create a new enrollment term for the specified account.
.EXAMPLE
   PS C:> Post-CanvasAccountsTerms -AccountId $SomeAccountIdObj -Name $SomeNameObj -StartAt $SomeStartAtObj -EndAt $SomeEndAtObj -SisTermId $SomeSisTermIdObj
#>
function Post-CanvasAccountsTerms {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The name of the term.
        [Parameter(Mandatory=$false)]
        $Name,

        # The day/time the term starts. Accepts times in ISO 8601 format, e.g. 2015-01-10T18:48:00Z.
        [Parameter(Mandatory=$false)]
        $StartAt,

        # The day/time the term ends. Accepts times in ISO 8601 format, e.g. 2015-01-10T18:48:00Z.
        [Parameter(Mandatory=$false)]
        $EndAt,

        # The unique SIS identifier for the term.
        [Parameter(Mandatory=$false)]
        $SisTermId
	)

    $uri = "/api/v1/accounts/{0}/terms" -f $AccountId 

	$Body = @{}

	if ($Name) {$Body["enrollment_term[name]"] = $Name}

	if ($StartAt) {$Body["enrollment_term[start_at]"] = $StartAt}

	if ($EndAt) {$Body["enrollment_term[end_at]"] = $EndAt}

	if ($SisTermId) {$Body["enrollment_term[sis_term_id]"] = $SisTermId}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Update enrollment term 
.DESCRIPTION
   Update an existing enrollment term for the specified account.
.EXAMPLE
   PS C:> Put-CanvasAccountsTerms -AccountId $SomeAccountIdObj -Id $SomeIdObj -Name $SomeNameObj -StartAt $SomeStartAtObj -EndAt $SomeEndAtObj -SisTermId $SomeSisTermIdObj
#>
function Put-CanvasAccountsTerms {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The name of the term.
        [Parameter(Mandatory=$false)]
        $Name,

        # The day/time the term starts. Accepts times in ISO 8601 format, e.g. 2015-01-10T18:48:00Z.
        [Parameter(Mandatory=$false)]
        $StartAt,

        # The day/time the term ends. Accepts times in ISO 8601 format, e.g. 2015-01-10T18:48:00Z.
        [Parameter(Mandatory=$false)]
        $EndAt,

        # The unique SIS identifier for the term.
        [Parameter(Mandatory=$false)]
        $SisTermId
	)

    $uri = "/api/v1/accounts/{0}/terms/{1}" -f $AccountId, $Id 

	$Body = @{}

	if ($Name) {$Body["enrollment_term[name]"] = $Name}

	if ($StartAt) {$Body["enrollment_term[start_at]"] = $StartAt}

	if ($EndAt) {$Body["enrollment_term[end_at]"] = $EndAt}

	if ($SisTermId) {$Body["enrollment_term[sis_term_id]"] = $SisTermId}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Delete enrollment term 
.DESCRIPTION
   Delete the specified enrollment term.
.EXAMPLE
   PS C:> Delete-CanvasAccountsTerms -AccountId $SomeAccountIdObj -Id $SomeIdObj
#>
function Delete-CanvasAccountsTerms {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/accounts/{0}/terms/{1}" -f $AccountId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   List enrollment terms 
.DESCRIPTION
   Return all of the terms in the account.
.EXAMPLE
   PS C:> Get-CanvasAccountsTerms -AccountId $SomeAccountIdObj -WorkflowState $SomeWorkflowStateObj
#>
function Get-CanvasAccountsTerms {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # If set, only returns terms that are in the given state. Defaults to 'active'.
		#Allowed values: active, deleted, all 
        [Parameter(Mandatory=$false)]
        $WorkflowState
	)

    $uri = "/api/v1/accounts/{0}/terms" -f $AccountId 

	$Body = @{}

	if ($WorkflowState) {$Body["workflow_state[]"] = $WorkflowState}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List enrollments 
.DESCRIPTION
   Depending on the URL given, return either (1) all of the enrollments in a course, (2) all of the enrollments in a section or (3) all of a user's enrollments. This includes student, teacher, TA, and observer enrollments. If a user has multiple enrollments in a context (e.g. as a teacher and a student or in multiple course sections), each enrollment will be listed separately. note: Currently, only an admin user can return other users' enrollments. A user can, however, return his/her own enrollments.
.EXAMPLE
   PS C:> Get-CanvasCoursesEnrollments -CourseId $SomeCourseIdObj -Type $SomeTypeObj -Role $SomeRoleObj -State $SomeStateObj -Include $SomeIncludeObj -user_id $Someuser_idObj -grading_period_id $Somegrading_period_idObj -SisAccountId $SomeSisAccountIdObj -SisCourseId $SomeSisCourseIdObj -SisSectionId $SomeSisSectionIdObj -SisUserId $SomeSisUserIdObj
#>
function Get-CanvasCoursesEnrollments {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # A list of enrollment types to return. Accepted values are 'StudentEnrollment', 'TeacherEnrollment', 'TaEnrollment', 'DesignerEnrollment', and 'ObserverEnrollment.' If omitted, all enrollment types are returned. This argument is ignored if `role` is given.
        [Parameter(Mandatory=$false)]
        $Type,

        # A list of enrollment roles to return. Accepted values include course-level roles created by the Add Role API as well as the base enrollment types accepted by the `type` argument above.
        [Parameter(Mandatory=$false)]
        $Role,

        # Filter by enrollment state. If omitted, 'active' and 'invited' enrollments are returned. When querying a user's enrollments (either via user_id argument or via user enrollments endpoint), the following additional synthetic states are supported: âcurrent_and_invitedâ|âcurrent_and_futureâ|âcurrent_and_concludedâ
		#Allowed values: active, invited, creation_pending, deleted, rejected, completed, inactive 
        [Parameter(Mandatory=$false)]
        $State,

        # Array of additional information to include on the enrollment or user records. âavatar_urlâ and âgroup_idsâ will be returned on the user record.
		#Allowed values: avatar_url, group_ids, locked, observed_users, can_be_removed 
        [Parameter(Mandatory=$false)]
        $Include,

        # Filter by user_id (only valid for course or section enrollment queries). If set to the current user's id, this is a way to determine if the user has any enrollments in the course or section, independent of whether the user has permission to view other people on the roster.
        [Parameter(Mandatory=$false)]
        $user_id,

        # Return grades for the given grading_period. If this parameter is not specified, the returned grades will be for the whole course.
        [Parameter(Mandatory=$false)]
        $grading_period_id,

        # Returns only enrollments for the specified SIS account ID(s). Does not look into subaccounts. May pass in array or string.
        [Parameter(Mandatory=$false)]
        $SisAccountId,

        # Returns only enrollments matching the specified SIS course ID(s). May pass in array or string.
        [Parameter(Mandatory=$false)]
        $SisCourseId,

        # Returns only section enrollments matching the specified SIS section ID(s). May pass in array or string.
        [Parameter(Mandatory=$false)]
        $SisSectionId,

        # Returns only enrollments for the specified SIS user ID(s). May pass in array or string.
        [Parameter(Mandatory=$false)]
        $SisUserId
	)

    $uri = "/api/v1/courses/{0}/enrollments" -f $CourseId 

	$Body = @{}

	if ($Type) {$Body["type[]"] = $Type}

	if ($Role) {$Body["role[]"] = $Role}

	if ($State) {$Body["state[]"] = $State}

	if ($Include) {$Body["include[]"] = $Include}

	if ($user_id) {$Body["user_id"] = $user_id}

	if ($grading_period_id) {$Body["grading_period_id"] = $grading_period_id}

	if ($SisAccountId) {$Body["sis_account_id[]"] = $SisAccountId}

	if ($SisCourseId) {$Body["sis_course_id[]"] = $SisCourseId}

	if ($SisSectionId) {$Body["sis_section_id[]"] = $SisSectionId}

	if ($SisUserId) {$Body["sis_user_id[]"] = $SisUserId}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Enrollment by ID 
.DESCRIPTION
   Get an Enrollment object by Enrollment ID
.EXAMPLE
   PS C:> Get-CanvasAccountsEnrollments -AccountId $SomeAccountIdObj -Id $SomeIdObj -id $SomeidObj
#><#
function Get-CanvasAccountsEnrollments {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The ID of the enrollment object
        [Parameter(Mandatory=$true)]
        $id
	)

    $uri = "/api/v1/accounts/{0}/enrollments/{1}" -f $AccountId, $Id 

	$Body = @{}

	$Body["id"] = $id

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}
#>


<#
.Synopsis
   Enroll a user 
.DESCRIPTION
   Create a new user enrollment for a course or section.
.EXAMPLE
   PS C:> Post-CanvasCoursesEnrollments -CourseId $SomeCourseIdObj -UserId $SomeUserIdObj -Type $SomeTypeObj -Role $SomeRoleObj -RoleId $SomeRoleIdObj -EnrollmentState $SomeEnrollmentStateObj -CourseSectionId $SomeCourseSectionIdObj -LimitPrivilegesToCourseSection $SomeLimitPrivilegesToCourseSectionObj -Notify $SomeNotifyObj -SelfEnrollmentCode $SomeSelfEnrollmentCodeObj -SelfEnrolled $SomeSelfEnrolledObj -AssociatedUserId $SomeAssociatedUserIdObj
#>
function Post-CanvasCoursesEnrollments {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The ID of the user to be enrolled in the course.
        [Parameter(Mandatory=$true)]
        $UserId,

        # Enroll the user as a student, teacher, TA, observer, or designer. If no value is given, the type will be inferred by enrollment if supplied, otherwise 'StudentEnrollment' will be used.
		#Allowed values: StudentEnrollment, TeacherEnrollment, TaEnrollment, ObserverEnrollment, DesignerEnrollment 
        [Parameter(Mandatory=$true)]
        $Type,

        # Assigns a custom course-level role to the user.
        [Parameter(Mandatory=$false)]
        $Role,

        # Assigns a custom course-level role to the user.
        [Parameter(Mandatory=$false)]
        $RoleId,

        # If set to 'active,' student will be immediately enrolled in the course. Otherwise they will be required to accept a course invitation. Default is 'invited.'.
		#If set to 'inactive', student will be listed in the course roster for teachers, but will not be able to participate in the course until their enrollment is activated.
		#Allowed values: active, invited, inactive 
        [Parameter(Mandatory=$false)]
        $EnrollmentState,

        # The ID of the course section to enroll the student in. If the section-specific URL is used, this argument is redundant and will be ignored.
        [Parameter(Mandatory=$false)]
        $CourseSectionId,

        # If set, the enrollment will only allow the user to see and interact with users enrolled in the section given by course_section_id.
		#For teachers and TAs, this includes grading privileges.
		#Section-limited students will not see any users (including teachers and TAs) not enrolled in their sections.
		#Users may have other enrollments that grant privileges to multiple sections in the same course.
        [Parameter(Mandatory=$false)]
        $LimitPrivilegesToCourseSection,

        # If true, a notification will be sent to the enrolled user. Notifications are not sent by default.
        [Parameter(Mandatory=$false)]
        $Notify,

        # If the current user is not allowed to manage enrollments in this course, but the course allows self-enrollment, the user can self- enroll as a student in the default section by passing in a valid code. When self-enrolling, the user_id must be 'self'. The enrollment_state will be set to 'active' and all other arguments will be ignored.
        [Parameter(Mandatory=$false)]
        $SelfEnrollmentCode,

        # If true, marks the enrollment as a self-enrollment, which gives students the ability to drop the course if desired. Defaults to false.
        [Parameter(Mandatory=$false)]
        $SelfEnrolled,

        # For an observer enrollment, the ID of a student to observe. The caller must have manage_students permission in the course. This is a one-off operation; to automatically observe all a student's enrollments (for example, as a parent), please use the User Observees API.
        [Parameter(Mandatory=$false)]
        $AssociatedUserId
	)

    $uri = "/api/v1/courses/{0}/enrollments" -f $CourseId 

	$Body = @{}

	$Body["enrollment[user_id]"] = $UserId

	$Body["enrollment[type]"] = $Type

	if ($Role) {$Body["enrollment[role]"] = $Role}

	if ($RoleId) {$Body["enrollment[role_id]"] = $RoleId}

	if ($EnrollmentState) {$Body["enrollment[enrollment_state]"] = $EnrollmentState}

	if ($CourseSectionId) {$Body["enrollment[course_section_id]"] = $CourseSectionId}

	if ($LimitPrivilegesToCourseSection) {$Body["enrollment[limit_privileges_to_course_section]"] = $LimitPrivilegesToCourseSection}

	if ($Notify) {$Body["enrollment[notify]"] = $Notify}

	if ($SelfEnrollmentCode) {$Body["enrollment[self_enrollment_code]"] = $SelfEnrollmentCode}

	if ($SelfEnrolled) {$Body["enrollment[self_enrolled]"] = $SelfEnrolled}

	if ($AssociatedUserId) {$Body["enrollment[associated_user_id]"] = $AssociatedUserId}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Conclude, deactivate, or delete an enrollment 
.DESCRIPTION
   Conclude, deactivate, or delete an enrollment. If the task argument isn't given, the enrollment will be concluded.
.EXAMPLE
   PS C:> Delete-CanvasCoursesEnrollments -CourseId $SomeCourseIdObj -Id $SomeIdObj -task $SometaskObj
#>
function Delete-CanvasCoursesEnrollments {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The action to take on the enrollment. When inactive, a user will still appear in the course roster to admins, but be unable to participate. (âinactivateâ and âdeactivateâ are equivalent tasks)
		#Allowed values: conclude, delete, inactivate, deactivate 
        [Parameter(Mandatory=$false)]
        $task
	)

    $uri = "/api/v1/courses/{0}/enrollments/{1}" -f $CourseId, $Id 

	$Body = @{}

	if ($task) {$Body["task"] = $task}

    return Get-CanvasApiResult $uri -Method DELETE -RequestParameters $Body
}


<#
.Synopsis
   Re-activate an enrollment 
.DESCRIPTION
   Activates an inactive enrollment
.EXAMPLE
   PS C:> Put-CanvasCoursesEnrollmentsReactivate -CourseId $SomeCourseIdObj -Id $SomeIdObj
#>
function Put-CanvasCoursesEnrollmentsReactivate {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/enrollments/{1}/reactivate" -f $CourseId, $Id 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Create Error Report 
.DESCRIPTION
   Create a new error report documenting an experienced problem Performs the same action as when a user uses the âhelp -> report a problemâ dialog.
.EXAMPLE
   PS C:> Post-CanvasErrorReports -Subject $SomeSubjectObj -Url $SomeUrlObj -Email $SomeEmailObj -Comments $SomeCommentsObj -HttpEnv $SomeHttpEnvObj
#>
function Post-CanvasErrorReports {
[CmdletBinding()]

	Param
	(
        # The summary of the problem
        [Parameter(Mandatory=$true)]
        $Subject,

        # URL from which the report was issued
        [Parameter(Mandatory=$false)]
        $Url,

        # Email address for the reporting user
        [Parameter(Mandatory=$false)]
        $Email,

        # The long version of the story from the user one what they experienced
        [Parameter(Mandatory=$false)]
        $Comments,

        # A collection of metadata about the users' environment. If not provided, canvas will collect it based on information found in the request. (Doesn't have to be HTTPENV info, could be anything JSON object that can be serialized as a hash, a mobile app might include relevant metadata for itself)
        [Parameter(Mandatory=$false)]
        $HttpEnv
	)

    $uri = "/api/v1/error_reports" 

	$Body = @{}

	$Body["error[subject]"] = $Subject

	if ($Url) {$Body["error[url]"] = $Url}

	if ($Email) {$Body["error[email]"] = $Email}

	if ($Comments) {$Body["error[comments]"] = $Comments}

	if ($HttpEnv) {$Body["error[http_env]"] = $HttpEnv}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   List external tools 
.DESCRIPTION
   Returns the paginated list of external tools for the current context. See the get request docs for a single tool for a list of properties on an external tool.
.EXAMPLE
   PS C:> Get-CanvasCoursesExternalTools -CourseId $SomeCourseIdObj -search_term $Somesearch_termObj -selectable $SomeselectableObj -include_parents $Someinclude_parentsObj
#>
function Get-CanvasCoursesExternalTools {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The partial name of the tools to match and return.
        [Parameter(Mandatory=$false)]
        $search_term,

        # If true, then only tools that are meant to be selectable are returned
        [Parameter(Mandatory=$false)]
        $selectable,

        # If true, then include tools installed in all accounts above the current context
        [Parameter(Mandatory=$false)]
        $include_parents
	)

    $uri = "/api/v1/courses/{0}/external_tools" -f $CourseId 

	$Body = @{}

	if ($search_term) {$Body["search_term"] = $search_term}

	if ($selectable) {$Body["selectable"] = $selectable}

	if ($include_parents) {$Body["include_parents"] = $include_parents}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get a sessionless launch url for an external tool. 
.DESCRIPTION
   Returns a sessionless launch url for an external tool. NOTE: Either the id or url must be provided unless launch_type is assessment or module_item.
.EXAMPLE
   PS C:> Get-CanvasCoursesExternalToolsSessionlessLaunch -CourseId $SomeCourseIdObj -id $SomeidObj -url $SomeurlObj -assignment_id $Someassignment_idObj -module_item_id $Somemodule_item_idObj -launch_type $Somelaunch_typeObj
#>
function Get-CanvasCoursesExternalToolsSessionlessLaunch {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The external id of the tool to launch.
        [Parameter(Mandatory=$false)]
        $id,

        # The LTI launch url for the external tool.
        [Parameter(Mandatory=$false)]
        $url,

        # The assignment id for an assignment launch. Required if launch_type is set to âassessmentâ.
        [Parameter(Mandatory=$false)]
        $assignment_id,

        # The assignment id for a module item launch. Required if launch_type is set to âmodule_itemâ.
        [Parameter(Mandatory=$false)]
        $module_item_id,

        # The type of launch to perform on the external tool. Placement names (eg. âcourse_navigationâ) can also be specified to use the custom launch url for that placement; if done, the tool id must be provided.
		#Allowed values: assessment, module_item 
        [Parameter(Mandatory=$false)]
        $launch_type
	)

    $uri = "/api/v1/courses/{0}/external_tools/sessionless_launch" -f $CourseId 

	$Body = @{}

	if ($id) {$Body["id"] = $id}

	if ($url) {$Body["url"] = $url}

	if ($assignment_id) {$Body["assignment_id"] = $assignment_id}

	if ($module_item_id) {$Body["module_item_id"] = $module_item_id}

	if ($launch_type) {$Body["launch_type"] = $launch_type}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get a single external tool 
.DESCRIPTION
   Returns the specified external tool.
.EXAMPLE
   PS C:> Get-CanvasCoursesExternalTools -CourseId $SomeCourseIdObj -ExternalToolId $SomeExternalToolIdObj
#>
function Get-CanvasCoursesExternalTools {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The ExternalToolId
        [Parameter(Mandatory=$true)]
        $ExternalToolId
	)

    $uri = "/api/v1/courses/{0}/external_tools/{1}" -f $CourseId, $ExternalToolId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create an external tool 
.DESCRIPTION
   Create an external tool in the specified course/account. The created tool will be returned, see the âshowâ endpoint for an example.
.EXAMPLE
   PS C:> Post-CanvasCoursesExternalTools -CourseId $SomeCourseIdObj -name $SomenameObj -privacy_level $Someprivacy_levelObj -consumer_key $Someconsumer_keyObj -shared_secret $Someshared_secretObj -description $SomedescriptionObj -url $SomeurlObj -domain $SomedomainObj -icon_url $Someicon_urlObj -text $SometextObj -FieldName $SomeFieldNameObj -Url $SomeUrlObj -Enabled $SomeEnabledObj -Text $SomeTextObj -SelectionWidth $SomeSelectionWidthObj -SelectionHeight $SomeSelectionHeightObj -Url $SomeUrlObj -Enabled $SomeEnabledObj -Text $SomeTextObj -Url $SomeUrlObj -Enabled $SomeEnabledObj -Text $SomeTextObj -IconUrl $SomeIconUrlObj -Enabled $SomeEnabledObj -Text $SomeTextObj -Visibility $SomeVisibilityObj -Windowtarget $SomeWindowtargetObj -Default $SomeDefaultObj -Url $SomeUrlObj -Enabled $SomeEnabledObj -IconUrl $SomeIconUrlObj -SelectionWidth $SomeSelectionWidthObj -SelectionHeight $SomeSelectionHeightObj -MessageType $SomeMessageTypeObj -Url $SomeUrlObj -Enabled $SomeEnabledObj -Text $SomeTextObj -MessageType $SomeMessageTypeObj -Url $SomeUrlObj -Enabled $SomeEnabledObj -Text $SomeTextObj -MessageType $SomeMessageTypeObj -Url $SomeUrlObj -Enabled $SomeEnabledObj -MessageType $SomeMessageTypeObj -Url $SomeUrlObj -Enabled $SomeEnabledObj -MessageType $SomeMessageTypeObj -Url $SomeUrlObj -Enabled $SomeEnabledObj -IconUrl $SomeIconUrlObj -SelectionWidth $SomeSelectionWidthObj -SelectionHeight $SomeSelectionHeightObj -config_type $Someconfig_typeObj -config_xml $Someconfig_xmlObj -config_url $Someconfig_urlObj -not_selectable $Somenot_selectableObj -oauth_compliant $Someoauth_compliantObj
#><#
function Post-CanvasCoursesExternalTools {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The name of the tool
        [Parameter(Mandatory=$true)]
        $name,

        # What information to send to the external tool.
		#Allowed values: anonymous, name_only, public 
        [Parameter(Mandatory=$true)]
        $privacy_level,

        # The consumer key for the external tool
        [Parameter(Mandatory=$true)]
        $consumer_key,

        # The shared secret with the external tool
        [Parameter(Mandatory=$true)]
        $shared_secret,

        # A description of the tool
        [Parameter(Mandatory=$false)]
        $description,

        # The url to match links against. Either âurlâ or âdomainâ should be set, not both.
        [Parameter(Mandatory=$false)]
        $url,

        # The domain to match links against. Either âurlâ or âdomainâ should be set, not both.
        [Parameter(Mandatory=$false)]
        $domain,

        # The url of the icon to show for this tool
        [Parameter(Mandatory=$false)]
        $icon_url,

        # The default text to show for this tool
        [Parameter(Mandatory=$false)]
        $text,

        # Custom fields that will be sent to the tool consumer; can be used multiple times
        [Parameter(Mandatory=$false)]
        $FieldName,

        # The url of the external tool for account navigation
        [Parameter(Mandatory=$false)]
        $Url,

        # Set this to enable this feature
        [Parameter(Mandatory=$false)]
        $Enabled,

        # The text that will show on the left-tab in the account navigation
        [Parameter(Mandatory=$false)]
        $Text,

        # The width of the dialog the tool is launched in
        [Parameter(Mandatory=$false)]
        $SelectionWidth,

        # The height of the dialog the tool is launched in
        [Parameter(Mandatory=$false)]
        $SelectionHeight,

        # The url of the external tool for user navigation
        [Parameter(Mandatory=$false)]
        $Url,

        # Set this to enable this feature
        [Parameter(Mandatory=$false)]
        $Enabled,

        # The text that will show on the left-tab in the user navigation
        [Parameter(Mandatory=$false)]
        $Text,

        # The url of the external tool for right-side course home navigation menu
        [Parameter(Mandatory=$false)]
        $Url,

        # Set this to enable this feature
        [Parameter(Mandatory=$false)]
        $Enabled,

        # The text that will show on the right-side course home navigation menu
        [Parameter(Mandatory=$false)]
        $Text,

        # The url of the icon to show in the right-side course home navigation menu
        [Parameter(Mandatory=$false)]
        $IconUrl,

        # Set this to enable this feature
        [Parameter(Mandatory=$false)]
        $Enabled,

        # The text that will show on the left-tab in the course navigation
        [Parameter(Mandatory=$false)]
        $Text,

        # Who will see the navigation tab. âadminsâ for course admins, âmembersâ for students, null for everyone
		#Allowed values: admins, members 
        [Parameter(Mandatory=$false)]
        $Visibility,

        # Determines how the navigation tab will be opened. â_blankâ Launches the external tool in a new window or tab. â_selfâ (Default) Launches the external tool in an iframe inside of Canvas.
		#Allowed values: _blank, _self 
        [Parameter(Mandatory=$false)]
        $Windowtarget,

        # Whether the navigation option will show in the course by default or whether the teacher will have to explicitly enable it
        [Parameter(Mandatory=$false)]
        $Default,

        # The url of the external tool
        [Parameter(Mandatory=$false)]
        $Url,

        # Set this to enable this feature
        [Parameter(Mandatory=$false)]
        $Enabled,

        # The url of the icon to show in the WYSIWYG editor
        [Parameter(Mandatory=$false)]
        $IconUrl,

        # The width of the dialog the tool is launched in
        [Parameter(Mandatory=$false)]
        $SelectionWidth,

        # The height of the dialog the tool is launched in
        [Parameter(Mandatory=$false)]
        $SelectionHeight,

        # Set this to ContentItemSelectionRequest to tell the tool to use content-item; otherwise, omit
        [Parameter(Mandatory=$false)]
        $MessageType,

        # The url of the external tool
        [Parameter(Mandatory=$false)]
        $Url,

        # Set this to enable this feature
        [Parameter(Mandatory=$false)]
        $Enabled,

        # The text that will show on the homework submission tab
        [Parameter(Mandatory=$false)]
        $Text,

        # Set this to ContentItemSelectionRequest to tell the tool to use content-item; otherwise, omit
        [Parameter(Mandatory=$false)]
        $MessageType,

        # The url of the external tool
        [Parameter(Mandatory=$false)]
        $Url,

        # Set this to enable this feature
        [Parameter(Mandatory=$false)]
        $Enabled,

        # The text that will show for the link selection text
        [Parameter(Mandatory=$false)]
        $Text,

        # Set this to ContentItemSelectionRequest to tell the tool to use content-item; otherwise, omit
        [Parameter(Mandatory=$false)]
        $MessageType,

        # The url of the external tool
        [Parameter(Mandatory=$false)]
        $Url,

        # Set this to enable this feature
        [Parameter(Mandatory=$false)]
        $Enabled,

        # Set this to ContentItemSelectionRequest to tell the tool to use content-item; otherwise, omit
        [Parameter(Mandatory=$false)]
        $MessageType,

        # The url of the external tool
        [Parameter(Mandatory=$false)]
        $Url,

        # Set this to enable this feature
        [Parameter(Mandatory=$false)]
        $Enabled,

        # Set this to ContentItemSelectionRequest to tell the tool to use content-item; otherwise, omit
        [Parameter(Mandatory=$false)]
        $MessageType,

        # The url of the external tool
        [Parameter(Mandatory=$false)]
        $Url,

        # Set this to enable this feature
        [Parameter(Mandatory=$false)]
        $Enabled,

        # The url of the icon to show in the module external tool list
        [Parameter(Mandatory=$false)]
        $IconUrl,

        # The width of the dialog the tool is launched in
        [Parameter(Mandatory=$false)]
        $SelectionWidth,

        # The height of the dialog the tool is launched in
        [Parameter(Mandatory=$false)]
        $SelectionHeight,

        # Configuration can be passed in as CC xml instead of using query parameters. If this value is âby_urlâ or âby_xmlâ then an xml configuration will be expected in either the âconfig_xmlâ or âconfig_urlâ parameter. Note that the name parameter overrides the tool name provided in the xml
        [Parameter(Mandatory=$false)]
        $config_type,

        # XML tool configuration, as specified in the CC xml specification. This is required if âconfig_typeâ is set to âby_xmlâ
        [Parameter(Mandatory=$false)]
        $config_xml,

        # URL where the server can retrieve an XML tool configuration, as specified in the CC xml specification. This is required if âconfig_typeâ is set to âby_urlâ
        [Parameter(Mandatory=$false)]
        $config_url,

        # Default: false, if set to true the tool won't show up in the external tool selection UI in modules and assignments
        [Parameter(Mandatory=$false)]
        $not_selectable,

        # Default: false, if set to true LTI query params will not be copied to the post body.
        [Parameter(Mandatory=$false)]
        $oauth_compliant
	)

    $uri = "/api/v1/courses/{0}/external_tools" -f $CourseId 

	$Body = @{}

	$Body["name"] = $name

	$Body["privacy_level"] = $privacy_level

	$Body["consumer_key"] = $consumer_key

	$Body["shared_secret"] = $shared_secret

	if ($description) {$Body["description"] = $description}

	if ($url) {$Body["url"] = $url}

	if ($domain) {$Body["domain"] = $domain}

	if ($icon_url) {$Body["icon_url"] = $icon_url}

	if ($text) {$Body["text"] = $text}

	if ($FieldName) {$Body["custom_fields[field_name]"] = $FieldName}

	if ($Url) {$Body["account_navigation[url]"] = $Url}

	if ($Enabled) {$Body["account_navigation[enabled]"] = $Enabled}

	if ($Text) {$Body["account_navigation[text]"] = $Text}

	if ($SelectionWidth) {$Body["account_navigation[selection_width]"] = $SelectionWidth}

	if ($SelectionHeight) {$Body["account_navigation[selection_height]"] = $SelectionHeight}

	if ($Url) {$Body["user_navigation[url]"] = $Url}

	if ($Enabled) {$Body["user_navigation[enabled]"] = $Enabled}

	if ($Text) {$Body["user_navigation[text]"] = $Text}

	if ($Url) {$Body["course_home_sub_navigation[url]"] = $Url}

	if ($Enabled) {$Body["course_home_sub_navigation[enabled]"] = $Enabled}

	if ($Text) {$Body["course_home_sub_navigation[text]"] = $Text}

	if ($IconUrl) {$Body["course_home_sub_navigation[icon_url]"] = $IconUrl}

	if ($Enabled) {$Body["course_navigation[enabled]"] = $Enabled}

	if ($Text) {$Body["course_navigation[text]"] = $Text}

	if ($Visibility) {$Body["course_navigation[visibility]"] = $Visibility}

	if ($Windowtarget) {$Body["course_navigation[windowTarget]"] = $Windowtarget}

	if ($Default) {$Body["course_navigation[default]"] = $Default}

	if ($Url) {$Body["editor_button[url]"] = $Url}

	if ($Enabled) {$Body["editor_button[enabled]"] = $Enabled}

	if ($IconUrl) {$Body["editor_button[icon_url]"] = $IconUrl}

	if ($SelectionWidth) {$Body["editor_button[selection_width]"] = $SelectionWidth}

	if ($SelectionHeight) {$Body["editor_button[selection_height]"] = $SelectionHeight}

	if ($MessageType) {$Body["editor_button[message_type]"] = $MessageType}

	if ($Url) {$Body["homework_submission[url]"] = $Url}

	if ($Enabled) {$Body["homework_submission[enabled]"] = $Enabled}

	if ($Text) {$Body["homework_submission[text]"] = $Text}

	if ($MessageType) {$Body["homework_submission[message_type]"] = $MessageType}

	if ($Url) {$Body["link_selection[url]"] = $Url}

	if ($Enabled) {$Body["link_selection[enabled]"] = $Enabled}

	if ($Text) {$Body["link_selection[text]"] = $Text}

	if ($MessageType) {$Body["link_selection[message_type]"] = $MessageType}

	if ($Url) {$Body["migration_selection[url]"] = $Url}

	if ($Enabled) {$Body["migration_selection[enabled]"] = $Enabled}

	if ($MessageType) {$Body["migration_selection[message_type]"] = $MessageType}

	if ($Url) {$Body["tool_configuration[url]"] = $Url}

	if ($Enabled) {$Body["tool_configuration[enabled]"] = $Enabled}

	if ($MessageType) {$Body["tool_configuration[message_type]"] = $MessageType}

	if ($Url) {$Body["resource_selection[url]"] = $Url}

	if ($Enabled) {$Body["resource_selection[enabled]"] = $Enabled}

	if ($IconUrl) {$Body["resource_selection[icon_url]"] = $IconUrl}

	if ($SelectionWidth) {$Body["resource_selection[selection_width]"] = $SelectionWidth}

	if ($SelectionHeight) {$Body["resource_selection[selection_height]"] = $SelectionHeight}

	if ($config_type) {$Body["config_type"] = $config_type}

	if ($config_xml) {$Body["config_xml"] = $config_xml}

	if ($config_url) {$Body["config_url"] = $config_url}

	if ($not_selectable) {$Body["not_selectable"] = $not_selectable}

	if ($oauth_compliant) {$Body["oauth_compliant"] = $oauth_compliant}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Edit an external tool 
.DESCRIPTION
   Update the specified external tool. Uses same parameters as create
.EXAMPLE
   PS C:> Put-CanvasCoursesExternalTools -CourseId $SomeCourseIdObj -ExternalToolId $SomeExternalToolIdObj
#>
function Put-CanvasCoursesExternalTools {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The ExternalToolId
        [Parameter(Mandatory=$true)]
        $ExternalToolId
	)

    $uri = "/api/v1/courses/{0}/external_tools/{1}" -f $CourseId, $ExternalToolId 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Delete an external tool 
.DESCRIPTION
   Remove the specified external tool
.EXAMPLE
   PS C:> Delete-CanvasCoursesExternalTools -CourseId $SomeCourseIdObj -ExternalToolId $SomeExternalToolIdObj
#>
function Delete-CanvasCoursesExternalTools {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The ExternalToolId
        [Parameter(Mandatory=$true)]
        $ExternalToolId
	)

    $uri = "/api/v1/courses/{0}/external_tools/{1}" -f $CourseId, $ExternalToolId 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   List favorite courses 
.DESCRIPTION
   Retrieve the list of favorite courses for the current user. If the user has not chosen any favorites, then a selection of currently enrolled courses will be returned. See the List courses API for details on accepted include[] parameters.
.EXAMPLE
   PS C:> Get-CanvasUsersSelfFavoritesCourses
#>
function Get-CanvasUsersSelfFavoritesCourses {
[CmdletBinding()]

    $uri = "/api/v1/users/self/favorites/courses" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List favorite groups 
.DESCRIPTION
   Retrieve the list of favorite groups for the current user. If the user has not chosen any favorites, then a selection of groups that the user is a member of will be returned.
.EXAMPLE
   PS C:> Get-CanvasUsersSelfFavoritesGroups
#>
function Get-CanvasUsersSelfFavoritesGroups {
[CmdletBinding()]

    $uri = "/api/v1/users/self/favorites/groups" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Add course to favorites 
.DESCRIPTION
   Add a course to the current user's favorites. If the course is already in the user's favorites, nothing happens.
.EXAMPLE
   PS C:> Post-CanvasUsersSelfFavoritesCourses -Id $SomeIdObj -id $SomeidObj
#><#
function Post-CanvasUsersSelfFavoritesCourses {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The ID or SIS ID of the course to add. The current user must be registered in the course.
        [Parameter(Mandatory=$true)]
        $id
	)

    $uri = "/api/v1/users/self/favorites/courses/{0}" -f $Id 

	$Body = @{}

	$Body["id"] = $id

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Add group to favorites 
.DESCRIPTION
   Add a group to the current user's favorites. If the group is already in the user's favorites, nothing happens.
.EXAMPLE
   PS C:> Post-CanvasUsersSelfFavoritesGroups -Id $SomeIdObj -id $SomeidObj
#><#
function Post-CanvasUsersSelfFavoritesGroups {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The ID or SIS ID of the group to add. The current user must be a member of the group.
        [Parameter(Mandatory=$true)]
        $id
	)

    $uri = "/api/v1/users/self/favorites/groups/{0}" -f $Id 

	$Body = @{}

	$Body["id"] = $id

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Remove course from favorites 
.DESCRIPTION
   Remove a course from the current user's favorites.
.EXAMPLE
   PS C:> Delete-CanvasUsersSelfFavoritesCourses -Id $SomeIdObj -id $SomeidObj
#><#
function Delete-CanvasUsersSelfFavoritesCourses {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # the ID or SIS ID of the course to remove
        [Parameter(Mandatory=$true)]
        $id
	)

    $uri = "/api/v1/users/self/favorites/courses/{0}" -f $Id 

	$Body = @{}

	$Body["id"] = $id

    return Get-CanvasApiResult $uri -Method DELETE -RequestParameters $Body
}
#>

<#
.Synopsis
   Remove group from favorites 
.DESCRIPTION
   Remove a group from the current user's favorites.
.EXAMPLE
   PS C:> Delete-CanvasUsersSelfFavoritesGroups -Id $SomeIdObj -id $SomeidObj
#><#
function Delete-CanvasUsersSelfFavoritesGroups {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # the ID or SIS ID of the group to remove
        [Parameter(Mandatory=$true)]
        $id
	)

    $uri = "/api/v1/users/self/favorites/groups/{0}" -f $Id 

	$Body = @{}

	$Body["id"] = $id

    return Get-CanvasApiResult $uri -Method DELETE -RequestParameters $Body
}
#>

<#
.Synopsis
   Reset course favorites 
.DESCRIPTION
   Reset the current user's course favorites to the default automatically generated list of enrolled courses
.EXAMPLE
   PS C:> Delete-CanvasUsersSelfFavoritesCourses
#>
function Delete-CanvasUsersSelfFavoritesCourses {
[CmdletBinding()]

    $uri = "/api/v1/users/self/favorites/courses" 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Reset group favorites 
.DESCRIPTION
   Reset the current user's group favorites to the default automatically generated list of enrolled group
.EXAMPLE
   PS C:> Delete-CanvasUsersSelfFavoritesGroups
#>
function Delete-CanvasUsersSelfFavoritesGroups {
[CmdletBinding()]

    $uri = "/api/v1/users/self/favorites/groups" 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   List features 
.DESCRIPTION
   List all features that apply to a given Account, Course, or User.
.EXAMPLE
   PS C:> Get-CanvasCoursesFeatures -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesFeatures {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/features" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List enabled features 
.DESCRIPTION
   List all features that are enabled on a given Account, Course, or User. Only the feature names are returned.
.EXAMPLE
   PS C:> Get-CanvasCoursesFeaturesEnabled -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesFeaturesEnabled {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/features/enabled" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get feature flag 
.DESCRIPTION
   Get the feature flag that applies to a given Account, Course, or User. The flag may be defined on the object, or it may be inherited from a parent account. You can look at the context_id and context_type of the returned object to determine which is the case. If these fields are missing, then the object is the global Canvas default.
.EXAMPLE
   PS C:> Get-CanvasCoursesFeaturesFlags -CourseId $SomeCourseIdObj -Feature $SomeFeatureObj
#>
function Get-CanvasCoursesFeaturesFlags {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Feature
        [Parameter(Mandatory=$true)]
        $Feature
	)

    $uri = "/api/v1/courses/{0}/features/flags/{1}" -f $CourseId, $Feature 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Set feature flag 
.DESCRIPTION
   Set a feature flag for a given Account, Course, or User. This call will fail if a parent account sets a feature flag for the same feature in any state other than âallowedâ.
.EXAMPLE
   PS C:> Put-CanvasCoursesFeaturesFlags -CourseId $SomeCourseIdObj -Feature $SomeFeatureObj -state $SomestateObj
#>
function Put-CanvasCoursesFeaturesFlags {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Feature
        [Parameter(Mandatory=$true)]
        $Feature,

        # âoffâ 
		#The feature is not available for the course, user, or account and sub-accounts.
		#âallowedâ 
		#(valid only on accounts) The feature is off in the account, but may be enabled in sub-accounts and courses by setting a feature flag on the sub-account or course.
		#âonâ 
		#The feature is turned on unconditionally for the user, course, or account and sub-accounts.
		#Allowed values: off, allowed, on 
        [Parameter(Mandatory=$false)]
        $state
	)

    $uri = "/api/v1/courses/{0}/features/flags/{1}" -f $CourseId, $Feature 

	$Body = @{}

	if ($state) {$Body["state"] = $state}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Remove feature flag 
.DESCRIPTION
   Remove feature flag for a given Account, Course, or User. (Note that the flag must be defined on the Account, Course, or User directly.) The object will then inherit the feature flags from a higher account, if any exist. If this flag was 'on' or 'off', then lower-level account flags that were masked by this one will apply again.
.EXAMPLE
   PS C:> Delete-CanvasCoursesFeaturesFlags -CourseId $SomeCourseIdObj -Feature $SomeFeatureObj
#>
function Delete-CanvasCoursesFeaturesFlags {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Feature
        [Parameter(Mandatory=$true)]
        $Feature
	)

    $uri = "/api/v1/courses/{0}/features/flags/{1}" -f $CourseId, $Feature 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Get quota information 
.DESCRIPTION
   Returns the total and used storage quota for the course, group, or user.
.EXAMPLE
   PS C:> Get-CanvasCoursesFilesQuota -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesFilesQuota {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/files/quota" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List files 
.DESCRIPTION
   Returns the paginated list of files for the folder or course.
.EXAMPLE
   PS C:> Get-CanvasCoursesFiles -CourseId $SomeCourseIdObj -ContentTypes $SomeContentTypesObj -search_term $Somesearch_termObj -Include $SomeIncludeObj -Only $SomeOnlyObj -sort $SomesortObj -order $SomeorderObj
#>
function Get-CanvasCoursesFiles {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # Filter results by content-type. You can specify type/subtype pairs (e.g., 'image/jpeg'), or simply types (e.g., 'image', which will match 'image/gif', 'image/jpeg', etc.).
        [Parameter(Mandatory=$false)]
        $ContentTypes,

        # The partial name of the files to match and return.
        [Parameter(Mandatory=$false)]
        $search_term,

        # Array of additional information to include.
		#âuserâ 
		#the user who uploaded the file or last edited its content
		#âusage_rightsâ 
		#copyright and license information for the file (see UsageRights)
		#Allowed values: user 
        [Parameter(Mandatory=$false)]
        $Include,

        # Array of information to restrict to. Overrides include[]
		#ânamesâ 
		#only returns file name information
        [Parameter(Mandatory=$false)]
        $Only,

        # Sort results by this field. Defaults to 'name'. Note that `sort=user` implies `include[]=user`.
		#Allowed values: name, size, created_at, updated_at, content_type, user 
        [Parameter(Mandatory=$false)]
        $sort,

        # The sorting order. Defaults to 'asc'.
		#Allowed values: asc, desc 
        [Parameter(Mandatory=$false)]
        $order
	)

    $uri = "/api/v1/courses/{0}/files" -f $CourseId 

	$Body = @{}

	if ($ContentTypes) {$Body["content_types[]"] = $ContentTypes}

	if ($search_term) {$Body["search_term"] = $search_term}

	if ($Include) {$Body["include[]"] = $Include}

	if ($Only) {$Body["only[]"] = $Only}

	if ($sort) {$Body["sort"] = $sort}

	if ($order) {$Body["order"] = $order}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get public inline preview url 
.DESCRIPTION
   Determine the URL that should be used for inline preview of the file.
.EXAMPLE
   PS C:> Get-CanvasFilesPublicUrl -Id $SomeIdObj -submission_id $Somesubmission_idObj
#>
function Get-CanvasFilesPublicUrl {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The id of the submission the file is associated with. Provide this argument to gain access to a file that has been submitted to an assignment (Canvas will verify that the file belongs to the submission and the calling user has rights to view the submission).
        [Parameter(Mandatory=$false)]
        $submission_id
	)

    $uri = "/api/v1/files/{0}/public_url" -f $Id 

	$Body = @{}

	if ($submission_id) {$Body["submission_id"] = $submission_id}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get file 
.DESCRIPTION
   Returns the standard attachment json object
.EXAMPLE
   PS C:> Get-CanvasFiles -Id $SomeIdObj -Include $SomeIncludeObj
#>
function Get-CanvasFiles {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Array of additional information to include.
		#âuserâ 
		#the user who uploaded the file or last edited its content
		#âusage_rightsâ 
		#copyright and license information for the file (see UsageRights)
		#Allowed values: user 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/files/{0}" -f $Id 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Update file 
.DESCRIPTION
   Update some settings on the specified file
.EXAMPLE
   PS C:> Put-CanvasFiles -Id $SomeIdObj -name $SomenameObj -parent_folder_id $Someparent_folder_idObj -on_duplicate $Someon_duplicateObj -lock_at $Somelock_atObj -unlock_at $Someunlock_atObj -locked $SomelockedObj -hidden $SomehiddenObj
#>
function Put-CanvasFiles {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The new display name of the file
        [Parameter(Mandatory=$false)]
        $name,

        # The id of the folder to move this file into. The new folder must be in the same context as the original parent folder. If the file is in a context without folders this does not apply.
        [Parameter(Mandatory=$false)]
        $parent_folder_id,

        # If the file is moved to a folder containing a file with the same name, or renamed to a name matching an existing file, the API call will fail unless this parameter is supplied.
		#âoverwriteâ 
		#Replace the existing file with the same name
		#ârenameâ 
		#Add a qualifier to make the new filename unique
		#Allowed values: overwrite, rename 
        [Parameter(Mandatory=$false)]
        $on_duplicate,

        # The datetime to lock the file at
        [Parameter(Mandatory=$false)]
        $lock_at,

        # The datetime to unlock the file at
        [Parameter(Mandatory=$false)]
        $unlock_at,

        # Flag the file as locked
        [Parameter(Mandatory=$false)]
        $locked,

        # Flag the file as hidden
        [Parameter(Mandatory=$false)]
        $hidden
	)

    $uri = "/api/v1/files/{0}" -f $Id 

	$Body = @{}

	if ($name) {$Body["name"] = $name}

	if ($parent_folder_id) {$Body["parent_folder_id"] = $parent_folder_id}

	if ($on_duplicate) {$Body["on_duplicate"] = $on_duplicate}

	if ($lock_at) {$Body["lock_at"] = $lock_at}

	if ($unlock_at) {$Body["unlock_at"] = $unlock_at}

	if ($locked) {$Body["locked"] = $locked}

	if ($hidden) {$Body["hidden"] = $hidden}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Delete file 
.DESCRIPTION
   Remove the specified file
.EXAMPLE
   PS C:> Delete-CanvasFiles -Id $SomeIdObj
#>
function Delete-CanvasFiles {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/files/{0}" -f $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   List folders 
.DESCRIPTION
   Returns the paginated list of folders in the folder.
.EXAMPLE
   PS C:> Get-CanvasFoldersFolders -Id $SomeIdObj
#>
function Get-CanvasFoldersFolders {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/folders/{0}/folders" -f $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List all folders 
.DESCRIPTION
   Returns the paginated list of all folders for the given context. This will be returned as a flat list containing all subfolders as well.
.EXAMPLE
   PS C:> Get-CanvasCoursesFolders -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesFolders {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/folders" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Resolve path 
.DESCRIPTION
   Given the full path to a folder, returns a list of all Folders in the path hierarchy, starting at the root folder, and ending at the requested folder. The given path is relative to the context's root folder and does not include the root folder's name (e.g., âcourse filesâ). If an empty path is given, the context's root folder alone is returned. Otherwise, if no folder exists with the given full path, a Not Found error is returned.
.EXAMPLE
   PS C:> Get-CanvasCoursesFoldersByPath -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesFoldersByPath {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/folders/by_path/{1}" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get folder 
.DESCRIPTION
   Returns the details for a folder You can get the root folder from a context by using 'root' as the :id. For example, you could get the root folder for a course like:
.EXAMPLE
   PS C:> Get-CanvasCoursesFolders -CourseId $SomeCourseIdObj -Id $SomeIdObj
#>
function Get-CanvasCoursesFolders {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/folders/{1}" -f $CourseId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Update folder 
.DESCRIPTION
   Updates a folder
.EXAMPLE
   PS C:> Put-CanvasFolders -Id $SomeIdObj -name $SomenameObj -parent_folder_id $Someparent_folder_idObj -lock_at $Somelock_atObj -unlock_at $Someunlock_atObj -locked $SomelockedObj -hidden $SomehiddenObj -position $SomepositionObj
#>
function Put-CanvasFolders {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The new name of the folder
        [Parameter(Mandatory=$false)]
        $name,

        # The id of the folder to move this folder into. The new folder must be in the same context as the original parent folder.
        [Parameter(Mandatory=$false)]
        $parent_folder_id,

        # The datetime to lock the folder at
        [Parameter(Mandatory=$false)]
        $lock_at,

        # The datetime to unlock the folder at
        [Parameter(Mandatory=$false)]
        $unlock_at,

        # Flag the folder as locked
        [Parameter(Mandatory=$false)]
        $locked,

        # Flag the folder as hidden
        [Parameter(Mandatory=$false)]
        $hidden,

        # Set an explicit sort position for the folder
        [Parameter(Mandatory=$false)]
        $position
	)

    $uri = "/api/v1/folders/{0}" -f $Id 

	$Body = @{}

	if ($name) {$Body["name"] = $name}

	if ($parent_folder_id) {$Body["parent_folder_id"] = $parent_folder_id}

	if ($lock_at) {$Body["lock_at"] = $lock_at}

	if ($unlock_at) {$Body["unlock_at"] = $unlock_at}

	if ($locked) {$Body["locked"] = $locked}

	if ($hidden) {$Body["hidden"] = $hidden}

	if ($position) {$Body["position"] = $position}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Create folder 
.DESCRIPTION
   Creates a folder in the specified context
.EXAMPLE
   PS C:> Post-CanvasCoursesFolders -CourseId $SomeCourseIdObj -name $SomenameObj -parent_folder_id $Someparent_folder_idObj -parent_folder_path $Someparent_folder_pathObj -lock_at $Somelock_atObj -unlock_at $Someunlock_atObj -locked $SomelockedObj -hidden $SomehiddenObj -position $SomepositionObj
#>
function Post-CanvasCoursesFolders {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The name of the folder
        [Parameter(Mandatory=$true)]
        $name,

        # The id of the folder to store the file in. If this and parent_folder_path are sent an error will be returned. If neither is given, a default folder will be used.
        [Parameter(Mandatory=$false)]
        $parent_folder_id,

        # The path of the folder to store the new folder in. The path separator is the forward slash `/`, never a back slash. The parent folder will be created if it does not already exist. This parameter only applies to new folders in a context that has folders, such as a user, a course, or a group. If this and parent_folder_id are sent an error will be returned. If neither is given, a default folder will be used.
        [Parameter(Mandatory=$false)]
        $parent_folder_path,

        # The datetime to lock the folder at
        [Parameter(Mandatory=$false)]
        $lock_at,

        # The datetime to unlock the folder at
        [Parameter(Mandatory=$false)]
        $unlock_at,

        # Flag the folder as locked
        [Parameter(Mandatory=$false)]
        $locked,

        # Flag the folder as hidden
        [Parameter(Mandatory=$false)]
        $hidden,

        # Set an explicit sort position for the folder
        [Parameter(Mandatory=$false)]
        $position
	)

    $uri = "/api/v1/courses/{0}/folders" -f $CourseId 

	$Body = @{}

	$Body["name"] = $name

	if ($parent_folder_id) {$Body["parent_folder_id"] = $parent_folder_id}

	if ($parent_folder_path) {$Body["parent_folder_path"] = $parent_folder_path}

	if ($lock_at) {$Body["lock_at"] = $lock_at}

	if ($unlock_at) {$Body["unlock_at"] = $unlock_at}

	if ($locked) {$Body["locked"] = $locked}

	if ($hidden) {$Body["hidden"] = $hidden}

	if ($position) {$Body["position"] = $position}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Delete folder 
.DESCRIPTION
   Remove the specified folder. You can only delete empty folders unless you set the 'force' flag
.EXAMPLE
   PS C:> Delete-CanvasFolders -Id $SomeIdObj -force $SomeforceObj
#>
function Delete-CanvasFolders {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Set to 'true' to allow deleting a non-empty folder
        [Parameter(Mandatory=$false)]
        $force
	)

    $uri = "/api/v1/folders/{0}" -f $Id 

	$Body = @{}

	if ($force) {$Body["force"] = $force}

    return Get-CanvasApiResult $uri -Method DELETE -RequestParameters $Body
}


<#
.Synopsis
   Upload a file 
.DESCRIPTION
   Upload a file to a folder. This API endpoint is the first step in uploading a file. See the File Upload Documentation for details on the file upload workflow. Only those with the âManage Filesâ permission on a course or group can upload files to a folder in that course or group.
.EXAMPLE
   PS C:> Post-CanvasFoldersFiles -FolderId $SomeFolderIdObj
#>
function Post-CanvasFoldersFiles {
[CmdletBinding()]

	Param
	(
        # The FolderId
        [Parameter(Mandatory=$true)]
        $FolderId
	)

    $uri = "/api/v1/folders/{0}/files" -f $FolderId 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   Copy a file 
.DESCRIPTION
   Copy a file from elsewhere in Canvas into a folder. Copying a file across contexts (between courses and users) is permitted, but the source and destination must belong to the same institution.
.EXAMPLE
   PS C:> Post-CanvasFoldersCopyFile -DestFolderId $SomeDestFolderIdObj -source_file_id $Somesource_file_idObj -on_duplicate $Someon_duplicateObj
#>
function Post-CanvasFoldersCopyFile {
[CmdletBinding()]

	Param
	(
        # The DestFolderId
        [Parameter(Mandatory=$true)]
        $DestFolderId,

        # The id of the source file
        [Parameter(Mandatory=$true)]
        $source_file_id,

        # What to do if a file with the same name already exists at the destination. If such a file exists and this parameter is not given, the call will fail.
		#âoverwriteâ 
		#Replace an existing file with the same name
		#ârenameâ 
		#Add a qualifier to make the new filename unique
		#Allowed values: overwrite, rename 
        [Parameter(Mandatory=$false)]
        $on_duplicate
	)

    $uri = "/api/v1/folders/{0}/copy_file" -f $DestFolderId 

	$Body = @{}

	$Body["source_file_id"] = $source_file_id

	if ($on_duplicate) {$Body["on_duplicate"] = $on_duplicate}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Copy a folder 
.DESCRIPTION
   Copy a folder (and its contents) from elsewhere in Canvas into a folder. Copying a folder across contexts (between courses and users) is permitted, but the source and destination must belong to the same institution. If the source and destination folders are in the same context, the source folder may not contain the destination folder. A folder will be renamed at its destination if another folder with the same name already exists.
.EXAMPLE
   PS C:> Post-CanvasFoldersCopyFolder -DestFolderId $SomeDestFolderIdObj -source_folder_id $Somesource_folder_idObj
#>
function Post-CanvasFoldersCopyFolder {
[CmdletBinding()]

	Param
	(
        # The DestFolderId
        [Parameter(Mandatory=$true)]
        $DestFolderId,

        # The id of the source folder
        [Parameter(Mandatory=$true)]
        $source_folder_id
	)

    $uri = "/api/v1/folders/{0}/copy_folder" -f $DestFolderId 

	$Body = @{}

	$Body["source_folder_id"] = $source_folder_id

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Set usage rights 
.DESCRIPTION
   Sets copyright and license information for one or more files
.EXAMPLE
   PS C:> Put-CanvasCoursesUsageRights -CourseId $SomeCourseIdObj -FileIds $SomeFileIdsObj -FolderIds $SomeFolderIdsObj -publish $SomepublishObj -UseJustification $SomeUseJustificationObj -LegalCopyright $SomeLegalCopyrightObj -License $SomeLicenseObj
#>
function Put-CanvasCoursesUsageRights {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # List of ids of files to set usage rights for.
        [Parameter(Mandatory=$true)]
        $FileIds,

        # List of ids of folders to search for files to set usage rights for. Note that new files uploaded to these folders do not automatically inherit these rights.
        [Parameter(Mandatory=$false)]
        $FolderIds,

        # Whether the file(s) or folder(s) should be published on save, provided that usage rights have been specified (set to `true` to publish on save).
        [Parameter(Mandatory=$false)]
        $publish,

        # The intellectual property justification for using the files in Canvas
		#Allowed values: own_copyright, used_by_permission, fair_use, public_domain, creative_commons 
        [Parameter(Mandatory=$true)]
        $UseJustification,

        # The legal copyright line for the files
        [Parameter(Mandatory=$false)]
        $LegalCopyright,

        # The license that applies to the files. See the List licenses endpoint for the supported license types.
        [Parameter(Mandatory=$false)]
        $License
	)

    $uri = "/api/v1/courses/{0}/usage_rights" -f $CourseId 

	$Body = @{}

	$Body["file_ids[]"] = $FileIds

	if ($FolderIds) {$Body["folder_ids[]"] = $FolderIds}

	if ($publish) {$Body["publish"] = $publish}

	$Body["usage_rights[use_justification]"] = $UseJustification

	if ($LegalCopyright) {$Body["usage_rights[legal_copyright]"] = $LegalCopyright}

	if ($License) {$Body["usage_rights[license]"] = $License}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Remove usage rights 
.DESCRIPTION
   Removes copyright and license information associated with one or more files
.EXAMPLE
   PS C:> Delete-CanvasCoursesUsageRights -CourseId $SomeCourseIdObj -FileIds $SomeFileIdsObj -FolderIds $SomeFolderIdsObj
#>
function Delete-CanvasCoursesUsageRights {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # List of ids of files to remove associated usage rights from.
        [Parameter(Mandatory=$true)]
        $FileIds,

        # List of ids of folders. Usage rights will be removed from all files in these folders.
        [Parameter(Mandatory=$false)]
        $FolderIds
	)

    $uri = "/api/v1/courses/{0}/usage_rights" -f $CourseId 

	$Body = @{}

	$Body["file_ids[]"] = $FileIds

	if ($FolderIds) {$Body["folder_ids[]"] = $FolderIds}

    return Get-CanvasApiResult $uri -Method DELETE -RequestParameters $Body
}


<#
.Synopsis
   List licenses 
.DESCRIPTION
   Lists licenses that can be applied
.EXAMPLE
   PS C:> Get-CanvasCoursesContentLicenses -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesContentLicenses {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/content_licenses" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Query by assignment. 
.DESCRIPTION
   List grade change events for a given assignment.
.EXAMPLE
   PS C:> Get-CanvasAuditGradeChangeAssignments -AssignmentId $SomeAssignmentIdObj -start_time $Somestart_timeObj -end_time $Someend_timeObj
#>
function Get-CanvasAuditGradeChangeAssignments {
[CmdletBinding()]

	Param
	(
        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The beginning of the time range from which you want events.
        [Parameter(Mandatory=$false)]
        $start_time,

        # The end of the time range from which you want events.
        [Parameter(Mandatory=$false)]
        $end_time
	)

    $uri = "/api/v1/audit/grade_change/assignments/{0}" -f $AssignmentId 

	$Body = @{}

	if ($start_time) {$Body["start_time"] = $start_time}

	if ($end_time) {$Body["end_time"] = $end_time}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Query by course. 
.DESCRIPTION
   List grade change events for a given course.
.EXAMPLE
   PS C:> Get-CanvasAuditGradeChangeCourses -CourseId $SomeCourseIdObj -start_time $Somestart_timeObj -end_time $Someend_timeObj
#>
function Get-CanvasAuditGradeChangeCourses {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The beginning of the time range from which you want events.
        [Parameter(Mandatory=$false)]
        $start_time,

        # The end of the time range from which you want events.
        [Parameter(Mandatory=$false)]
        $end_time
	)

    $uri = "/api/v1/audit/grade_change/courses/{0}" -f $CourseId 

	$Body = @{}

	if ($start_time) {$Body["start_time"] = $start_time}

	if ($end_time) {$Body["end_time"] = $end_time}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Query by student. 
.DESCRIPTION
   List grade change events for a given student.
.EXAMPLE
   PS C:> Get-CanvasAuditGradeChangeStudents -StudentId $SomeStudentIdObj -start_time $Somestart_timeObj -end_time $Someend_timeObj
#>
function Get-CanvasAuditGradeChangeStudents {
[CmdletBinding()]

	Param
	(
        # The StudentId
        [Parameter(Mandatory=$true)]
        $StudentId,

        # The beginning of the time range from which you want events.
        [Parameter(Mandatory=$false)]
        $start_time,

        # The end of the time range from which you want events.
        [Parameter(Mandatory=$false)]
        $end_time
	)

    $uri = "/api/v1/audit/grade_change/students/{0}" -f $StudentId 

	$Body = @{}

	if ($start_time) {$Body["start_time"] = $start_time}

	if ($end_time) {$Body["end_time"] = $end_time}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Query by grader. 
.DESCRIPTION
   List grade change events for a given grader.
.EXAMPLE
   PS C:> Get-CanvasAuditGradeChangeGraders -GraderId $SomeGraderIdObj -start_time $Somestart_timeObj -end_time $Someend_timeObj
#>
function Get-CanvasAuditGradeChangeGraders {
[CmdletBinding()]

	Param
	(
        # The GraderId
        [Parameter(Mandatory=$true)]
        $GraderId,

        # The beginning of the time range from which you want events.
        [Parameter(Mandatory=$false)]
        $start_time,

        # The end of the time range from which you want events.
        [Parameter(Mandatory=$false)]
        $end_time
	)

    $uri = "/api/v1/audit/grade_change/graders/{0}" -f $GraderId 

	$Body = @{}

	if ($start_time) {$Body["start_time"] = $start_time}

	if ($end_time) {$Body["end_time"] = $end_time}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Days in gradebook history for this course 
.DESCRIPTION
   Returns a map of dates to grader/assignment groups
.EXAMPLE
   PS C:> Get-CanvasCoursesGradebookHistoryDays -CourseId $SomeCourseIdObj -course_id $Somecourse_idObj
#>
function Get-CanvasCoursesGradebookHistoryDays {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The id of the contextual course for this API call
        [Parameter(Mandatory=$true)]
        $course_id
	)

    $uri = "/api/v1/courses/{0}/gradebook_history/days" -f $CourseId 

	$Body = @{}

	$Body["course_id"] = $course_id

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Details for a given date in gradebook history for this course 
.DESCRIPTION
   Returns the graders who worked on this day, along with the assignments they worked on. More details can be obtained by selecting a grader and assignment and calling the 'submissions' api endpoint for a given date.
.EXAMPLE
   PS C:> Get-CanvasCoursesGradebookHistory -CourseId $SomeCourseIdObj -Date $SomeDateObj -course_id $Somecourse_idObj -date $SomedateObj
#><#
function Get-CanvasCoursesGradebookHistory {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Date
        [Parameter(Mandatory=$true)]
        $Date,

        # The id of the contextual course for this API call
        [Parameter(Mandatory=$true)]
        $course_id,

        # The date for which you would like to see detailed information
        [Parameter(Mandatory=$true)]
        $date
	)

    $uri = "/api/v1/courses/{0}/gradebook_history/{1}" -f $CourseId, $Date 

	$Body = @{}

	$Body["course_id"] = $course_id

	$Body["date"] = $date

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}
#>

<#
.Synopsis
   Lists submissions 
.DESCRIPTION
   Gives a nested list of submission versions
.EXAMPLE
   PS C:> Get-CanvasCoursesGradebookHistoryGradersAssignmentsSubmissions -CourseId $SomeCourseIdObj -Date $SomeDateObj -GraderId $SomeGraderIdObj -AssignmentId $SomeAssignmentIdObj -course_id $Somecourse_idObj -date $SomedateObj -grader_id $Somegrader_idObj -assignment_id $Someassignment_idObj
#><#
function Get-CanvasCoursesGradebookHistoryGradersAssignmentsSubmissions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Date
        [Parameter(Mandatory=$true)]
        $Date,

        # The GraderId
        [Parameter(Mandatory=$true)]
        $GraderId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The id of the contextual course for this API call
        [Parameter(Mandatory=$true)]
        $course_id,

        # The date for which you would like to see submissions
        [Parameter(Mandatory=$true)]
        $date,

        # The ID of the grader for which you want to see submissions
        [Parameter(Mandatory=$true)]
        $grader_id,

        # The ID of the assignment for which you want to see submissions
        [Parameter(Mandatory=$true)]
        $assignment_id
	)

    $uri = "/api/v1/courses/{0}/gradebook_history/{1}/graders/{2}/assignments/{3}/submissions" -f $CourseId, $Date, $GraderId, $AssignmentId 

	$Body = @{}

	$Body["course_id"] = $course_id

	$Body["date"] = $date

	$Body["grader_id"] = $grader_id

	$Body["assignment_id"] = $assignment_id

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}
#>

<#
.Synopsis
   List uncollated submission versions 
.DESCRIPTION
   Gives a paginated, uncollated list of submission versions for all matching submissions in the context. This SubmissionVersion objects will not include the new_grade or previous_grade keys, only the grade; same for graded_at and grader.
.EXAMPLE
   PS C:> Get-CanvasCoursesGradebookHistoryFeed -CourseId $SomeCourseIdObj -course_id $Somecourse_idObj -assignment_id $Someassignment_idObj -user_id $Someuser_idObj -ascending $SomeascendingObj
#>
function Get-CanvasCoursesGradebookHistoryFeed {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The id of the contextual course for this API call
        [Parameter(Mandatory=$true)]
        $course_id,

        # The ID of the assignment for which you want to see submissions. If absent, versions of submissions from any assignment in the course are included.
        [Parameter(Mandatory=$false)]
        $assignment_id,

        # The ID of the user for which you want to see submissions. If absent, versions of submissions from any user in the course are included.
        [Parameter(Mandatory=$false)]
        $user_id,

        # Returns submission versions in ascending date order (oldest first). If absent, returns submission versions in descending date order (newest first).
        [Parameter(Mandatory=$false)]
        $ascending
	)

    $uri = "/api/v1/courses/{0}/gradebook_history/feed" -f $CourseId 

	$Body = @{}

	$Body["course_id"] = $course_id

	if ($assignment_id) {$Body["assignment_id"] = $assignment_id}

	if ($user_id) {$Body["user_id"] = $user_id}

	if ($ascending) {$Body["ascending"] = $ascending}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List grading periods 
.DESCRIPTION
   Returns the list of grading periods for the current course.
.EXAMPLE
   PS C:> Get-CanvasAccountsGradingPeriods -AccountId $SomeAccountIdObj
#>
function Get-CanvasAccountsGradingPeriods {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId
	)

    $uri = "/api/v1/accounts/{0}/grading_periods" -f $AccountId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get a single grading period 
.DESCRIPTION
   Returns the grading period with the given id
.EXAMPLE
   PS C:> Get-CanvasCoursesGradingPeriods -CourseId $SomeCourseIdObj -Id $SomeIdObj
#>
function Get-CanvasCoursesGradingPeriods {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/grading_periods/{1}" -f $CourseId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Update a single grading period 
.DESCRIPTION
   Update an existing grading period.
.EXAMPLE
   PS C:> Put-CanvasCoursesGradingPeriods -CourseId $SomeCourseIdObj -Id $SomeIdObj -GradingPeriods[StartDate] $SomeGradingPeriods[StartDate]Obj -GradingPeriods[EndDate] $SomeGradingPeriods[EndDate]Obj -GradingPeriods[Weight] $SomeGradingPeriods[Weight]Obj
#><#
function Put-CanvasCoursesGradingPeriods {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The date the grading period starts.
        [Parameter(Mandatory=$true)]
        $GradingPeriods[StartDate],

        # no description
        [Parameter(Mandatory=$true)]
        $GradingPeriods[EndDate],

        # A weight value that contributes to the overall weight of a grading period set which is used to calculate how much assignments in this period contribute to the total grade
        [Parameter(Mandatory=$false)]
        $GradingPeriods[Weight]
	)

    $uri = "/api/v1/courses/{0}/grading_periods/{1}" -f $CourseId, $Id 

	$Body = @{}

	$Body["grading_periods[][start_date]"] = $GradingPeriods[StartDate]

	$Body["grading_periods[][end_date]"] = $GradingPeriods[EndDate]

	if ($GradingPeriods[Weight]) {$Body["grading_periods[][weight]"] = $GradingPeriods[Weight]}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}
#>

<#
.Synopsis
   Delete a grading period 
.DESCRIPTION
   204 No Content response code is returned if the deletion was successful.
.EXAMPLE
   PS C:> Delete-CanvasCoursesGradingPeriods -CourseId $SomeCourseIdObj -Id $SomeIdObj
#>
function Delete-CanvasCoursesGradingPeriods {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/grading_periods/{1}" -f $CourseId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Create a new grading standard 
.DESCRIPTION
   Create a new grading standard If grading_scheme_entry arguments are omitted, then a default grading scheme will be set. The default scheme is as follows:
.EXAMPLE
   PS C:> Post-CanvasAccountsGradingStandards -AccountId $SomeAccountIdObj -title $SometitleObj -GradingSchemeEntry[Name] $SomeGradingSchemeEntry[Name]Obj -GradingSchemeEntry[Value] $SomeGradingSchemeEntry[Value]Obj
#><#
function Post-CanvasAccountsGradingStandards {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The title for the Grading Standard.
        [Parameter(Mandatory=$true)]
        $title,

        # The name for an entry value within a GradingStandard that describes the range of the value e.g. A-
        [Parameter(Mandatory=$true)]
        $GradingSchemeEntry[Name],

        # The value for the name of the entry within a GradingStandard. The entry represents the lower bound of the range for the entry. This range includes the value up to the next entry in the GradingStandard, or 100 if there is no upper bound. The lowest value will have a lower bound range of 0. e.g. 93
        [Parameter(Mandatory=$true)]
        $GradingSchemeEntry[Value]
	)

    $uri = "/api/v1/accounts/{0}/grading_standards" -f $AccountId 

	$Body = @{}

	$Body["title"] = $title

	$Body["grading_scheme_entry[][name]"] = $GradingSchemeEntry[Name]

	$Body["grading_scheme_entry[][value]"] = $GradingSchemeEntry[Value]

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   List the grading standards available in a context. 
.DESCRIPTION
   Returns the list of grading standards in the given context that are visible to user.
.EXAMPLE
   PS C:> Get-CanvasCoursesGradingStandards -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesGradingStandards {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/grading_standards" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List group categories for a context 
.DESCRIPTION
   Returns a list of group categories in a context
.EXAMPLE
   PS C:> Get-CanvasAccountsGroupCategories -AccountId $SomeAccountIdObj
#>
function Get-CanvasAccountsGroupCategories {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId
	)

    $uri = "/api/v1/accounts/{0}/group_categories" -f $AccountId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get a single group category 
.DESCRIPTION
   Returns the data for a single group category, or a 401 if the caller doesn't have the rights to see it.
.EXAMPLE
   PS C:> Get-CanvasGroupCategories -GroupCategoryId $SomeGroupCategoryIdObj
#>
function Get-CanvasGroupCategories {
[CmdletBinding()]

	Param
	(
        # The GroupCategoryId
        [Parameter(Mandatory=$true)]
        $GroupCategoryId
	)

    $uri = "/api/v1/group_categories/{0}" -f $GroupCategoryId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create a Group Category 
.DESCRIPTION
   Create a new group category
.EXAMPLE
   PS C:> Post-CanvasAccountsGroupCategories -AccountId $SomeAccountIdObj -name $SomenameObj -self_signup $Someself_signupObj -auto_leader $Someauto_leaderObj -group_limit $Somegroup_limitObj -create_group_count $Somecreate_group_countObj -split_group_count $Somesplit_group_countObj
#>
function Post-CanvasAccountsGroupCategories {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # Name of the group category
        [Parameter(Mandatory=$true)]
        $name,

        # Allow students to sign up for a group themselves (Course Only). valid values are:
		#âenabledâ 
		#allows students to self sign up for any group in course
		#ârestrictedâ 
		#allows students to self sign up only for groups in the same section null disallows self sign up
		#Allowed values: enabled, restricted 
        [Parameter(Mandatory=$false)]
        $self_signup,

        # Assigns group leaders automatically when generating and allocating students to groups Valid values are:
		#âfirstâ 
		#the first student to be allocated to a group is the leader
		#ârandomâ 
		#a random student from all members is chosen as the leader
		#Allowed values: first, random 
        [Parameter(Mandatory=$false)]
        $auto_leader,

        # Limit the maximum number of users in each group (Course Only). Requires self signup.
        [Parameter(Mandatory=$false)]
        $group_limit,

        # Create this number of groups (Course Only).
        [Parameter(Mandatory=$false)]
        $create_group_count,

        # (Deprecated) Create this number of groups, and evenly distribute students among them. not allowed with âenable_self_signupâ. because the group assignment happens synchronously, it's recommended that you instead use the assign_unassigned_members endpoint. (Course Only)
        [Parameter(Mandatory=$false)]
        $split_group_count
	)

    $uri = "/api/v1/accounts/{0}/group_categories" -f $AccountId 

	$Body = @{}

	$Body["name"] = $name

	if ($self_signup) {$Body["self_signup"] = $self_signup}

	if ($auto_leader) {$Body["auto_leader"] = $auto_leader}

	if ($group_limit) {$Body["group_limit"] = $group_limit}

	if ($create_group_count) {$Body["create_group_count"] = $create_group_count}

	if ($split_group_count) {$Body["split_group_count"] = $split_group_count}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Update a Group Category 
.DESCRIPTION
   Modifies an existing group category.
.EXAMPLE
   PS C:> Put-CanvasGroupCategories -GroupCategoryId $SomeGroupCategoryIdObj -name $SomenameObj -self_signup $Someself_signupObj -auto_leader $Someauto_leaderObj -group_limit $Somegroup_limitObj -create_group_count $Somecreate_group_countObj -split_group_count $Somesplit_group_countObj
#>
function Put-CanvasGroupCategories {
[CmdletBinding()]

	Param
	(
        # The GroupCategoryId
        [Parameter(Mandatory=$true)]
        $GroupCategoryId,

        # Name of the group category
        [Parameter(Mandatory=$false)]
        $name,

        # Allow students to sign up for a group themselves (Course Only). Valid values are:
		#âenabledâ 
		#allows students to self sign up for any group in course
		#ârestrictedâ 
		#allows students to self sign up only for groups in the same section null disallows self sign up
		#Allowed values: enabled, restricted 
        [Parameter(Mandatory=$false)]
        $self_signup,

        # Assigns group leaders automatically when generating and allocating students to groups Valid values are:
		#âfirstâ 
		#the first student to be allocated to a group is the leader
		#ârandomâ 
		#a random student from all members is chosen as the leader
		#Allowed values: first, random 
        [Parameter(Mandatory=$false)]
        $auto_leader,

        # Limit the maximum number of users in each group (Course Only). Requires self signup.
        [Parameter(Mandatory=$false)]
        $group_limit,

        # Create this number of groups (Course Only).
        [Parameter(Mandatory=$false)]
        $create_group_count,

        # (Deprecated) Create this number of groups, and evenly distribute students among them. not allowed with âenable_self_signupâ. because the group assignment happens synchronously, it's recommended that you instead use the assign_unassigned_members endpoint. (Course Only)
        [Parameter(Mandatory=$false)]
        $split_group_count
	)

    $uri = "/api/v1/group_categories/{0}" -f $GroupCategoryId 

	$Body = @{}

	if ($name) {$Body["name"] = $name}

	if ($self_signup) {$Body["self_signup"] = $self_signup}

	if ($auto_leader) {$Body["auto_leader"] = $auto_leader}

	if ($group_limit) {$Body["group_limit"] = $group_limit}

	if ($create_group_count) {$Body["create_group_count"] = $create_group_count}

	if ($split_group_count) {$Body["split_group_count"] = $split_group_count}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Delete a Group Category 
.DESCRIPTION
   Deletes a group category and all groups under it. Protected group categories can not be deleted, i.e. âcommunitiesâ and âstudent_organizedâ.
.EXAMPLE
   PS C:> Delete-CanvasGroupCategories -GroupCategoryId $SomeGroupCategoryIdObj
#>
function Delete-CanvasGroupCategories {
[CmdletBinding()]

	Param
	(
        # The GroupCategoryId
        [Parameter(Mandatory=$true)]
        $GroupCategoryId
	)

    $uri = "/api/v1/group_categories/{0}" -f $GroupCategoryId 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   List groups in group category 
.DESCRIPTION
   Returns a list of groups in a group category
.EXAMPLE
   PS C:> Get-CanvasGroupCategoriesGroups -GroupCategoryId $SomeGroupCategoryIdObj
#>
function Get-CanvasGroupCategoriesGroups {
[CmdletBinding()]

	Param
	(
        # The GroupCategoryId
        [Parameter(Mandatory=$true)]
        $GroupCategoryId
	)

    $uri = "/api/v1/group_categories/{0}/groups" -f $GroupCategoryId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List users in group category 
.DESCRIPTION
   Returns a list of users in the group category.
.EXAMPLE
   PS C:> Get-CanvasGroupCategoriesUsers -GroupCategoryId $SomeGroupCategoryIdObj -search_term $Somesearch_termObj -unassigned $SomeunassignedObj
#>
function Get-CanvasGroupCategoriesUsers {
[CmdletBinding()]

	Param
	(
        # The GroupCategoryId
        [Parameter(Mandatory=$true)]
        $GroupCategoryId,

        # The partial name or full ID of the users to match and return in the results list. Must be at least 3 characters.
        [Parameter(Mandatory=$false)]
        $search_term,

        # Set this value to true if you wish only to search unassigned users in the group category.
        [Parameter(Mandatory=$false)]
        $unassigned
	)

    $uri = "/api/v1/group_categories/{0}/users" -f $GroupCategoryId 

	$Body = @{}

	if ($search_term) {$Body["search_term"] = $search_term}

	if ($unassigned) {$Body["unassigned"] = $unassigned}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Assign unassigned members 
.DESCRIPTION
   Assign all unassigned members as evenly as possible among the existing student groups.
.EXAMPLE
   PS C:> Post-CanvasGroupCategoriesAssignUnassignedMembers -GroupCategoryId $SomeGroupCategoryIdObj -sync $SomesyncObj
#>
function Post-CanvasGroupCategoriesAssignUnassignedMembers {
[CmdletBinding()]

	Param
	(
        # The GroupCategoryId
        [Parameter(Mandatory=$true)]
        $GroupCategoryId,

        # The assigning is done asynchronously by default. If you would like to override this and have the assigning done synchronously, set this value to true.
        [Parameter(Mandatory=$false)]
        $sync
	)

    $uri = "/api/v1/group_categories/{0}/assign_unassigned_members" -f $GroupCategoryId 

	$Body = @{}

	if ($sync) {$Body["sync"] = $sync}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   List your groups 
.DESCRIPTION
   Returns a list of active groups for the current user.
.EXAMPLE
   PS C:> Get-CanvasUsersSelfGroups -context_type $Somecontext_typeObj -Include $SomeIncludeObj
#>
function Get-CanvasUsersSelfGroups {
[CmdletBinding()]

	Param
	(
        # Only include groups that are in this type of context.
		#Allowed values: Account, Course 
        [Parameter(Mandatory=$false)]
        $context_type,

        # âtabsâ: Include the list of tabs configured for each group. See the List available tabs API for more information.
		#Allowed values: tabs 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/users/self/groups" 

	$Body = @{}

	if ($context_type) {$Body["context_type"] = $context_type}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List the groups available in a context. 
.DESCRIPTION
   Returns the list of active groups in the given context that are visible to user.
.EXAMPLE
   PS C:> Get-CanvasAccountsGroups -AccountId $SomeAccountIdObj -only_own_groups $Someonly_own_groupsObj -Include $SomeIncludeObj
#>
function Get-CanvasAccountsGroups {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # Will only include groups that the user belongs to if this is set
        [Parameter(Mandatory=$false)]
        $only_own_groups,

        # âtabsâ: Include the list of tabs configured for each group. See the List available tabs API for more information.
		#Allowed values: tabs 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/accounts/{0}/groups" -f $AccountId 

	$Body = @{}

	if ($only_own_groups) {$Body["only_own_groups"] = $only_own_groups}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get a single group 
.DESCRIPTION
   Returns the data for a single group, or a 401 if the caller doesn't have the rights to see it.
.EXAMPLE
   PS C:> Get-CanvasGroups -GroupId $SomeGroupIdObj -Include $SomeIncludeObj
#>
function Get-CanvasGroups {
[CmdletBinding()]

	Param
	(
        # The GroupId
        [Parameter(Mandatory=$true)]
        $GroupId,

        # âpermissionsâ: Include permissions the current user has for the group.
		#âtabsâ: Include the list of tabs configured for each group. See the List available tabs API for more information.
		#Allowed values: permissions, tabs 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/groups/{0}" -f $GroupId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create a group 
.DESCRIPTION
   Creates a new group. Groups created using the â/api/v1/groups/â endpoint will be community groups.
.EXAMPLE
   PS C:> Post-CanvasGroups -name $SomenameObj -description $SomedescriptionObj -is_public $Someis_publicObj -join_level $Somejoin_levelObj -storage_quota_mb $Somestorage_quota_mbObj
#>
function Post-CanvasGroups {
[CmdletBinding()]

	Param
	(
        # The name of the group
        [Parameter(Mandatory=$false)]
        $name,

        # A description of the group
        [Parameter(Mandatory=$false)]
        $description,

        # whether the group is public (applies only to community groups)
        [Parameter(Mandatory=$false)]
        $is_public,

        # no description
		#Allowed values: parent_context_auto_join, parent_context_request, invitation_only 
        [Parameter(Mandatory=$false)]
        $join_level,

        # The allowed file storage for the group, in megabytes. This parameter is ignored if the caller does not have the manage_storage_quotas permission.
        [Parameter(Mandatory=$false)]
        $storage_quota_mb
	)

    $uri = "/api/v1/groups" 

	$Body = @{}

	if ($name) {$Body["name"] = $name}

	if ($description) {$Body["description"] = $description}

	if ($is_public) {$Body["is_public"] = $is_public}

	if ($join_level) {$Body["join_level"] = $join_level}

	if ($storage_quota_mb) {$Body["storage_quota_mb"] = $storage_quota_mb}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Edit a group 
.DESCRIPTION
   Modifies an existing group. Note that to set an avatar image for the group, you must first upload the image file to the group, and the use the id in the response as the argument to this function. See the File Upload Documentation for details on the file upload workflow.
.EXAMPLE
   PS C:> Put-CanvasGroups -GroupId $SomeGroupIdObj -name $SomenameObj -description $SomedescriptionObj -is_public $Someis_publicObj -join_level $Somejoin_levelObj -avatar_id $Someavatar_idObj -storage_quota_mb $Somestorage_quota_mbObj -Members $SomeMembersObj
#>
function Put-CanvasGroups {
[CmdletBinding()]

	Param
	(
        # The GroupId
        [Parameter(Mandatory=$true)]
        $GroupId,

        # The name of the group
        [Parameter(Mandatory=$false)]
        $name,

        # A description of the group
        [Parameter(Mandatory=$false)]
        $description,

        # Whether the group is public (applies only to community groups). Currently you cannot set a group back to private once it has been made public.
        [Parameter(Mandatory=$false)]
        $is_public,

        # no description
		#Allowed values: parent_context_auto_join, parent_context_request, invitation_only 
        [Parameter(Mandatory=$false)]
        $join_level,

        # The id of the attachment previously uploaded to the group that you would like to use as the avatar image for this group.
        [Parameter(Mandatory=$false)]
        $avatar_id,

        # The allowed file storage for the group, in megabytes. This parameter is ignored if the caller does not have the manage_storage_quotas permission.
        [Parameter(Mandatory=$false)]
        $storage_quota_mb,

        # An array of user ids for users you would like in the group. Users not in the group will be sent invitations. Existing group members who aren't in the list will be removed from the group.
        [Parameter(Mandatory=$false)]
        $Members
	)

    $uri = "/api/v1/groups/{0}" -f $GroupId 

	$Body = @{}

	if ($name) {$Body["name"] = $name}

	if ($description) {$Body["description"] = $description}

	if ($is_public) {$Body["is_public"] = $is_public}

	if ($join_level) {$Body["join_level"] = $join_level}

	if ($avatar_id) {$Body["avatar_id"] = $avatar_id}

	if ($storage_quota_mb) {$Body["storage_quota_mb"] = $storage_quota_mb}

	if ($Members) {$Body["members[]"] = $Members}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Delete a group 
.DESCRIPTION
   Deletes a group and removes all members.
.EXAMPLE
   PS C:> Delete-CanvasGroups -GroupId $SomeGroupIdObj
#>
function Delete-CanvasGroups {
[CmdletBinding()]

	Param
	(
        # The GroupId
        [Parameter(Mandatory=$true)]
        $GroupId
	)

    $uri = "/api/v1/groups/{0}" -f $GroupId 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Invite others to a group 
.DESCRIPTION
   Sends an invitation to all supplied email addresses which will allow the receivers to join the group.
.EXAMPLE
   PS C:> Post-CanvasGroupsInvite -GroupId $SomeGroupIdObj -Invitees $SomeInviteesObj
#>
function Post-CanvasGroupsInvite {
[CmdletBinding()]

	Param
	(
        # The GroupId
        [Parameter(Mandatory=$true)]
        $GroupId,

        # An array of email addresses to be sent invitations.
        [Parameter(Mandatory=$true)]
        $Invitees
	)

    $uri = "/api/v1/groups/{0}/invite" -f $GroupId 

	$Body = @{}

	$Body["invitees[]"] = $Invitees

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   List group's users 
.DESCRIPTION
   Returns a list of users in the group.
.EXAMPLE
   PS C:> Get-CanvasGroupsUsers -GroupId $SomeGroupIdObj -search_term $Somesearch_termObj -Include $SomeIncludeObj
#>
function Get-CanvasGroupsUsers {
[CmdletBinding()]

	Param
	(
        # The GroupId
        [Parameter(Mandatory=$true)]
        $GroupId,

        # The partial name or full ID of the users to match and return in the results list. Must be at least 3 characters.
        [Parameter(Mandatory=$false)]
        $search_term,

        # âavatar_urlâ: Include users' avatar_urls.
		#Allowed values: avatar_url 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/groups/{0}/users" -f $GroupId 

	$Body = @{}

	if ($search_term) {$Body["search_term"] = $search_term}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Upload a file 
.DESCRIPTION
   Upload a file to the group. This API endpoint is the first step in uploading a file to a group. See the File Upload Documentation for details on the file upload workflow. Only those with the âManage Filesâ permission on a group can upload files to the group. By default, this is anybody participating in the group, or any admin over the group.
.EXAMPLE
   PS C:> Post-CanvasGroupsFiles -GroupId $SomeGroupIdObj
#>
function Post-CanvasGroupsFiles {
[CmdletBinding()]

	Param
	(
        # The GroupId
        [Parameter(Mandatory=$true)]
        $GroupId
	)

    $uri = "/api/v1/groups/{0}/files" -f $GroupId 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   Preview processed html 
.DESCRIPTION
   Preview html content processed for this group
.EXAMPLE
   PS C:> Post-CanvasGroupsPreviewHtml -GroupId $SomeGroupIdObj -html $SomehtmlObj
#>
function Post-CanvasGroupsPreviewHtml {
[CmdletBinding()]

	Param
	(
        # The GroupId
        [Parameter(Mandatory=$true)]
        $GroupId,

        # The html content to process
        [Parameter(Mandatory=$false)]
        $html
	)

    $uri = "/api/v1/groups/{0}/preview_html" -f $GroupId 

	$Body = @{}

	if ($html) {$Body["html"] = $html}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Group activity stream 
.DESCRIPTION
   Returns the current user's group-specific activity stream, paginated. For full documentation, see the API documentation for the user activity stream, in the user api.
.EXAMPLE
   PS C:> Get-CanvasGroupsActivityStream -GroupId $SomeGroupIdObj
#>
function Get-CanvasGroupsActivityStream {
[CmdletBinding()]

	Param
	(
        # The GroupId
        [Parameter(Mandatory=$true)]
        $GroupId
	)

    $uri = "/api/v1/groups/{0}/activity_stream" -f $GroupId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Group activity stream summary 
.DESCRIPTION
   Returns a summary of the current user's group-specific activity stream. For full documentation, see the API documentation for the user activity stream summary, in the user api.
.EXAMPLE
   PS C:> Get-CanvasGroupsActivityStreamSummary -GroupId $SomeGroupIdObj
#>
function Get-CanvasGroupsActivityStreamSummary {
[CmdletBinding()]

	Param
	(
        # The GroupId
        [Parameter(Mandatory=$true)]
        $GroupId
	)

    $uri = "/api/v1/groups/{0}/activity_stream/summary" -f $GroupId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List group memberships 
.DESCRIPTION
   List the members of a group.
.EXAMPLE
   PS C:> Get-CanvasGroupsMemberships -GroupId $SomeGroupIdObj -FilterStates $SomeFilterStatesObj
#>
function Get-CanvasGroupsMemberships {
[CmdletBinding()]

	Param
	(
        # The GroupId
        [Parameter(Mandatory=$true)]
        $GroupId,

        # Only list memberships with the given workflow_states. By default it will return all memberships.
		#Allowed values: accepted, invited, requested 
        [Parameter(Mandatory=$false)]
        $FilterStates
	)

    $uri = "/api/v1/groups/{0}/memberships" -f $GroupId 

	$Body = @{}

	if ($FilterStates) {$Body["filter_states[]"] = $FilterStates}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get a single group membership 
.DESCRIPTION
   Returns the group membership with the given membership id or user id.
.EXAMPLE
   PS C:> Get-CanvasGroupsMemberships -GroupId $SomeGroupIdObj -MembershipId $SomeMembershipIdObj
#>
function Get-CanvasGroupsMemberships {
[CmdletBinding()]

	Param
	(
        # The GroupId
        [Parameter(Mandatory=$true)]
        $GroupId,

        # The MembershipId
        [Parameter(Mandatory=$true)]
        $MembershipId
	)

    $uri = "/api/v1/groups/{0}/memberships/{1}" -f $GroupId, $MembershipId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create a membership 
.DESCRIPTION
   Join, or request to join, a group, depending on the join_level of the group. If the membership or join request already exists, then it is simply returned
.EXAMPLE
   PS C:> Post-CanvasGroupsMemberships -GroupId $SomeGroupIdObj -user_id $Someuser_idObj
#>
function Post-CanvasGroupsMemberships {
[CmdletBinding()]

	Param
	(
        # The GroupId
        [Parameter(Mandatory=$true)]
        $GroupId,

        # no description
        [Parameter(Mandatory=$false)]
        $user_id
	)

    $uri = "/api/v1/groups/{0}/memberships" -f $GroupId 

	$Body = @{}

	if ($user_id) {$Body["user_id"] = $user_id}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Update a membership 
.DESCRIPTION
   Accept a membership request, or add/remove moderator rights.
.EXAMPLE
   PS C:> Put-CanvasGroupsMemberships -GroupId $SomeGroupIdObj -MembershipId $SomeMembershipIdObj -workflow_state $Someworkflow_stateObj -moderator $SomemoderatorObj
#>
function Put-CanvasGroupsMemberships {
[CmdletBinding()]

	Param
	(
        # The GroupId
        [Parameter(Mandatory=$true)]
        $GroupId,

        # The MembershipId
        [Parameter(Mandatory=$true)]
        $MembershipId,

        # Currently, the only allowed value is âacceptedâ
		#Allowed values: accepted 
        [Parameter(Mandatory=$false)]
        $workflow_state,

        # no description
        [Parameter(Mandatory=$false)]
        $moderator
	)

    $uri = "/api/v1/groups/{0}/memberships/{1}" -f $GroupId, $MembershipId 

	$Body = @{}

	if ($workflow_state) {$Body["workflow_state"] = $workflow_state}

	if ($moderator) {$Body["moderator"] = $moderator}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Leave a group 
.DESCRIPTION
   Leave a group if you are allowed to leave (some groups, such as sets of course groups created by teachers, cannot be left). You may also use 'self' in place of a membership_id.
.EXAMPLE
   PS C:> Delete-CanvasGroupsMemberships -GroupId $SomeGroupIdObj -MembershipId $SomeMembershipIdObj
#>
function Delete-CanvasGroupsMemberships {
[CmdletBinding()]

	Param
	(
        # The GroupId
        [Parameter(Mandatory=$true)]
        $GroupId,

        # The MembershipId
        [Parameter(Mandatory=$true)]
        $MembershipId
	)

    $uri = "/api/v1/groups/{0}/memberships/{1}" -f $GroupId, $MembershipId 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Create JWT 
.DESCRIPTION
   Create a unique jwt for using with other canvas services Generates a different JWT each time it's called, each one expires after a short window (1 hour)
.EXAMPLE
   PS C:> Post-CanvasJwts
#>
function Post-CanvasJwts {
[CmdletBinding()]

    $uri = "/api/v1/jwts" 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   Create live assessment results 
.DESCRIPTION
   Creates live assessment results and adds them to a live assessment
.EXAMPLE
   PS C:> Post-CanvasCoursesLiveAssessmentsResults -CourseId $SomeCourseIdObj -AssessmentId $SomeAssessmentIdObj
#>
function Post-CanvasCoursesLiveAssessmentsResults {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssessmentId
        [Parameter(Mandatory=$true)]
        $AssessmentId
	)

    $uri = "/api/v1/courses/{0}/live_assessments/{1}/results" -f $CourseId, $AssessmentId 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   List live assessment results 
.DESCRIPTION
   Returns a list of live assessment results
.EXAMPLE
   PS C:> Get-CanvasCoursesLiveAssessmentsResults -CourseId $SomeCourseIdObj -AssessmentId $SomeAssessmentIdObj -user_id $Someuser_idObj
#>
function Get-CanvasCoursesLiveAssessmentsResults {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssessmentId
        [Parameter(Mandatory=$true)]
        $AssessmentId,

        # If set, restrict results to those for this user
        [Parameter(Mandatory=$false)]
        $user_id
	)

    $uri = "/api/v1/courses/{0}/live_assessments/{1}/results" -f $CourseId, $AssessmentId 

	$Body = @{}

	if ($user_id) {$Body["user_id"] = $user_id}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create or find a live assessment 
.DESCRIPTION
   Creates or finds an existing live assessment with the given key and aligns it with the linked outcome
.EXAMPLE
   PS C:> Post-CanvasCoursesLiveAssessments -CourseId $SomeCourseIdObj
#>
function Post-CanvasCoursesLiveAssessments {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/live_assessments" -f $CourseId 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   List live assessments 
.DESCRIPTION
   Returns a list of live assessments.
.EXAMPLE
   PS C:> Get-CanvasCoursesLiveAssessments -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesLiveAssessments {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/live_assessments" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List user logins 
.DESCRIPTION
   Given a user ID, return that user's logins for the given account.
.EXAMPLE
   PS C:> Get-CanvasAccountsLogins -AccountId $SomeAccountIdObj
#>
function Get-CanvasAccountsLogins {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId
	)

    $uri = "/api/v1/accounts/{0}/logins" -f $AccountId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create a user login 
.DESCRIPTION
   Create a new login for an existing user in the given account.
.EXAMPLE
   PS C:> Post-CanvasAccountsLogins -AccountId $SomeAccountIdObj -Id $SomeIdObj -UniqueId $SomeUniqueIdObj -Password $SomePasswordObj -SisUserId $SomeSisUserIdObj -IntegrationId $SomeIntegrationIdObj -AuthenticationProviderId $SomeAuthenticationProviderIdObj
#>
function Post-CanvasAccountsLogins {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The ID of the user to create the login for.
        [Parameter(Mandatory=$true)]
        $Id,

        # The unique ID for the new login.
        [Parameter(Mandatory=$true)]
        $UniqueId,

        # The new login's password.
        [Parameter(Mandatory=$false)]
        $Password,

        # SIS ID for the login. To set this parameter, the caller must be able to manage SIS permissions on the account.
        [Parameter(Mandatory=$false)]
        $SisUserId,

        # Integration ID for the login. To set this parameter, the caller must be able to manage SIS permissions on the account. The Integration ID is a secondary identifier useful for more complex SIS integrations.
        [Parameter(Mandatory=$false)]
        $IntegrationId,

        # The authentication provider this login is associated with. Logins associated with a specific provider can only be used with that provider. Legacy providers (LDAP, CAS, SAML) will search for logins associated with them, or unassociated logins. New providers will only search for logins explicitly associated with them. This can be the integer ID of the provider, or the type of the provider (in which case, it will find the first matching provider).
        [Parameter(Mandatory=$false)]
        $AuthenticationProviderId
	)

    $uri = "/api/v1/accounts/{0}/logins" -f $AccountId 

	$Body = @{}

	$Body["user[id]"] = $Id

	$Body["login[unique_id]"] = $UniqueId

	if ($Password) {$Body["login[password]"] = $Password}

	if ($SisUserId) {$Body["login[sis_user_id]"] = $SisUserId}

	if ($IntegrationId) {$Body["login[integration_id]"] = $IntegrationId}

	if ($AuthenticationProviderId) {$Body["login[authentication_provider_id]"] = $AuthenticationProviderId}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Edit a user login 
.DESCRIPTION
   Update an existing login for a user in the given account.
.EXAMPLE
   PS C:> Put-CanvasAccountsLogins -AccountId $SomeAccountIdObj -Id $SomeIdObj -UniqueId $SomeUniqueIdObj -Password $SomePasswordObj -SisUserId $SomeSisUserIdObj -IntegrationId $SomeIntegrationIdObj
#>
function Put-CanvasAccountsLogins {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The new unique ID for the login.
        [Parameter(Mandatory=$false)]
        $UniqueId,

        # The new password for the login. Can only be set by an admin user if admins are allowed to change passwords for the account.
        [Parameter(Mandatory=$false)]
        $Password,

        # SIS ID for the login. To set this parameter, the caller must be able to manage SIS permissions on the account.
        [Parameter(Mandatory=$false)]
        $SisUserId,

        # Integration ID for the login. To set this parameter, the caller must be able to manage SIS permissions on the account. The Integration ID is a secondary identifier useful for more complex SIS integrations.
        [Parameter(Mandatory=$false)]
        $IntegrationId
	)

    $uri = "/api/v1/accounts/{0}/logins/{1}" -f $AccountId, $Id 

	$Body = @{}

	if ($UniqueId) {$Body["login[unique_id]"] = $UniqueId}

	if ($Password) {$Body["login[password]"] = $Password}

	if ($SisUserId) {$Body["login[sis_user_id]"] = $SisUserId}

	if ($IntegrationId) {$Body["login[integration_id]"] = $IntegrationId}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Delete a user login 
.DESCRIPTION
   Delete an existing login.
.EXAMPLE
   PS C:> Delete-CanvasUsersLogins -UserId $SomeUserIdObj -Id $SomeIdObj
#>
function Delete-CanvasUsersLogins {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/users/{0}/logins/{1}" -f $UserId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   List students selected for moderation 
.DESCRIPTION
   
.EXAMPLE
   PS C:> Get-CanvasCoursesAssignmentsModeratedStudents -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj
#>
function Get-CanvasCoursesAssignmentsModeratedStudents {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/moderated_students" -f $CourseId, $AssignmentId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Select students for moderation 
.DESCRIPTION
   Returns an array of users that were selected for moderation
.EXAMPLE
   PS C:> Post-CanvasCoursesAssignmentsModeratedStudents -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -StudentIds $SomeStudentIdsObj
#>
function Post-CanvasCoursesAssignmentsModeratedStudents {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # user ids for students to select for moderation
        [Parameter(Mandatory=$false)]
        $StudentIds
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/moderated_students" -f $CourseId, $AssignmentId 

	$Body = @{}

	if ($StudentIds) {$Body["student_ids[]"] = $StudentIds}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Show provisional grade status for a student 
.DESCRIPTION
   Tell whether the student's submission needs one or more provisional grades.
.EXAMPLE
   PS C:> Get-CanvasCoursesAssignmentsProvisionalGradesStatus -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -student_id $Somestudent_idObj
#>
function Get-CanvasCoursesAssignmentsProvisionalGradesStatus {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The id of the student to show the status for
        [Parameter(Mandatory=$false)]
        $student_id
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/provisional_grades/status" -f $CourseId, $AssignmentId 

	$Body = @{}

	if ($student_id) {$Body["student_id"] = $student_id}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Select provisional grade 
.DESCRIPTION
   Choose which provisional grade the student should receive for a submission. The caller must have :moderate_grades rights.
.EXAMPLE
   PS C:> Put-CanvasCoursesAssignmentsProvisionalGradesSelect -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -ProvisionalGradeId $SomeProvisionalGradeIdObj
#>
function Put-CanvasCoursesAssignmentsProvisionalGradesSelect {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The ProvisionalGradeId
        [Parameter(Mandatory=$true)]
        $ProvisionalGradeId
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/provisional_grades/{2}/select" -f $CourseId, $AssignmentId, $ProvisionalGradeId 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Copy provisional grade 
.DESCRIPTION
   Given a provisional grade, copy the grade (and associated submission comments and rubric assessments) to a âfinalâ mark which can be edited or commented upon by a moderator prior to publication of grades. Notes:
.EXAMPLE
   PS C:> Post-CanvasCoursesAssignmentsProvisionalGradesCopyToFinalMark -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -ProvisionalGradeId $SomeProvisionalGradeIdObj
#>
function Post-CanvasCoursesAssignmentsProvisionalGradesCopyToFinalMark {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The ProvisionalGradeId
        [Parameter(Mandatory=$true)]
        $ProvisionalGradeId
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/provisional_grades/{2}/copy_to_final_mark" -f $CourseId, $AssignmentId, $ProvisionalGradeId 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   Publish provisional grades for an assignment 
.DESCRIPTION
   Publish the selected provisional grade for all submissions to an assignment. Use the âSelect provisional gradeâ endpoint to choose which provisional grade to publish for a particular submission. Students not in the moderation set will have their one and only provisional grade published. WARNING: This is irreversible. This will overwrite existing grades in the gradebook.
.EXAMPLE
   PS C:> Post-CanvasCoursesAssignmentsProvisionalGradesPublish -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj
#>
function Post-CanvasCoursesAssignmentsProvisionalGradesPublish {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/provisional_grades/publish" -f $CourseId, $AssignmentId 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   List modules 
.DESCRIPTION
   List the modules in a course
.EXAMPLE
   PS C:> Get-CanvasCoursesModules -CourseId $SomeCourseIdObj -Include $SomeIncludeObj -search_term $Somesearch_termObj -student_id $Somestudent_idObj
#>
function Get-CanvasCoursesModules {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # âitemsâ: Return module items inline if possible. This parameter suggests that Canvas return module items directly in the Module object JSON, to avoid having to make separate API requests for each module when enumerating modules and items. Canvas is free to omit 'items' for any particular module if it deems them too numerous to return inline. Callers must be prepared to use the List Module Items API if items are not returned.
		#âcontent_detailsâ: Requires include. Returns additional details with module items specific to their associated content items. Includes standard lock information for each item.
		#Allowed values: items, content_details 
        [Parameter(Mandatory=$false)]
        $Include,

        # The partial name of the modules (and module items, if include is specified) to match and return.
        [Parameter(Mandatory=$false)]
        $search_term,

        # Returns module completion information for the student with this id.
        [Parameter(Mandatory=$false)]
        $student_id
	)

    $uri = "/api/v1/courses/{0}/modules" -f $CourseId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

	if ($search_term) {$Body["search_term"] = $search_term}

	if ($student_id) {$Body["student_id"] = $student_id}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Show module 
.DESCRIPTION
   Get information about a single module
.EXAMPLE
   PS C:> Get-CanvasCoursesModules -CourseId $SomeCourseIdObj -Id $SomeIdObj -Include $SomeIncludeObj -student_id $Somestudent_idObj
#>
function Get-CanvasCoursesModules {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # âitemsâ: Return module items inline if possible. This parameter suggests that Canvas return module items directly in the Module object JSON, to avoid having to make separate API requests for each module when enumerating modules and items. Canvas is free to omit 'items' for any particular module if it deems them too numerous to return inline. Callers must be prepared to use the List Module Items API if items are not returned.
		#âcontent_detailsâ: Requires include. Returns additional details with module items specific to their associated content items. Includes standard lock information for each item.
		#Allowed values: items, content_details 
        [Parameter(Mandatory=$false)]
        $Include,

        # Returns module completion information for the student with this id.
        [Parameter(Mandatory=$false)]
        $student_id
	)

    $uri = "/api/v1/courses/{0}/modules/{1}" -f $CourseId, $Id 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

	if ($student_id) {$Body["student_id"] = $student_id}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create a module 
.DESCRIPTION
   Create and return a new module
.EXAMPLE
   PS C:> Post-CanvasCoursesModules -CourseId $SomeCourseIdObj -Name $SomeNameObj -UnlockAt $SomeUnlockAtObj -Position $SomePositionObj -RequireSequentialProgress $SomeRequireSequentialProgressObj -Module[PrerequisiteModuleIds] $SomeModule[PrerequisiteModuleIds]Obj -PublishFinalGrade $SomePublishFinalGradeObj
#><#
function Post-CanvasCoursesModules {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The name of the module
        [Parameter(Mandatory=$true)]
        $Name,

        # The date the module will unlock
        [Parameter(Mandatory=$false)]
        $UnlockAt,

        # The position of this module in the course (1-based)
        [Parameter(Mandatory=$false)]
        $Position,

        # Whether module items must be unlocked in order
        [Parameter(Mandatory=$false)]
        $RequireSequentialProgress,

        # IDs of Modules that must be completed before this one is unlocked. Prerequisite modules must precede this module (i.e. have a lower position value), otherwise they will be ignored
        [Parameter(Mandatory=$false)]
        $Module[PrerequisiteModuleIds],

        # Whether to publish the student's final grade for the course upon completion of this module.
        [Parameter(Mandatory=$false)]
        $PublishFinalGrade
	)

    $uri = "/api/v1/courses/{0}/modules" -f $CourseId 

	$Body = @{}

	$Body["module[name]"] = $Name

	if ($UnlockAt) {$Body["module[unlock_at]"] = $UnlockAt}

	if ($Position) {$Body["module[position]"] = $Position}

	if ($RequireSequentialProgress) {$Body["module[require_sequential_progress]"] = $RequireSequentialProgress}

	if ($Module[PrerequisiteModuleIds]) {$Body["module[prerequisite_module_ids][]"] = $Module[PrerequisiteModuleIds]}

	if ($PublishFinalGrade) {$Body["module[publish_final_grade]"] = $PublishFinalGrade}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Update a module 
.DESCRIPTION
   Update and return an existing module
.EXAMPLE
   PS C:> Put-CanvasCoursesModules -CourseId $SomeCourseIdObj -Id $SomeIdObj -Name $SomeNameObj -UnlockAt $SomeUnlockAtObj -Position $SomePositionObj -RequireSequentialProgress $SomeRequireSequentialProgressObj -Module[PrerequisiteModuleIds] $SomeModule[PrerequisiteModuleIds]Obj -PublishFinalGrade $SomePublishFinalGradeObj -Published $SomePublishedObj
#><#
function Put-CanvasCoursesModules {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The name of the module
        [Parameter(Mandatory=$false)]
        $Name,

        # The date the module will unlock
        [Parameter(Mandatory=$false)]
        $UnlockAt,

        # The position of the module in the course (1-based)
        [Parameter(Mandatory=$false)]
        $Position,

        # Whether module items must be unlocked in order
        [Parameter(Mandatory=$false)]
        $RequireSequentialProgress,

        # IDs of Modules that must be completed before this one is unlocked Prerequisite modules must precede this module (i.e. have a lower position value), otherwise they will be ignored
        [Parameter(Mandatory=$false)]
        $Module[PrerequisiteModuleIds],

        # Whether to publish the student's final grade for the course upon completion of this module.
        [Parameter(Mandatory=$false)]
        $PublishFinalGrade,

        # Whether the module is published and visible to students
        [Parameter(Mandatory=$false)]
        $Published
	)

    $uri = "/api/v1/courses/{0}/modules/{1}" -f $CourseId, $Id 

	$Body = @{}

	if ($Name) {$Body["module[name]"] = $Name}

	if ($UnlockAt) {$Body["module[unlock_at]"] = $UnlockAt}

	if ($Position) {$Body["module[position]"] = $Position}

	if ($RequireSequentialProgress) {$Body["module[require_sequential_progress]"] = $RequireSequentialProgress}

	if ($Module[PrerequisiteModuleIds]) {$Body["module[prerequisite_module_ids][]"] = $Module[PrerequisiteModuleIds]}

	if ($PublishFinalGrade) {$Body["module[publish_final_grade]"] = $PublishFinalGrade}

	if ($Published) {$Body["module[published]"] = $Published}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}
#>

<#
.Synopsis
   Delete module 
.DESCRIPTION
   Delete a module
.EXAMPLE
   PS C:> Delete-CanvasCoursesModules -CourseId $SomeCourseIdObj -Id $SomeIdObj
#>
function Delete-CanvasCoursesModules {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/modules/{1}" -f $CourseId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Re-lock module progressions 
.DESCRIPTION
   Resets module progressions to their default locked state and recalculates them based on the current requirements. Adding progression requirements to an active course will not lock students out of modules they have already unlocked unless this action is called.
.EXAMPLE
   PS C:> Put-CanvasCoursesModulesRelock -CourseId $SomeCourseIdObj -Id $SomeIdObj
#>
function Put-CanvasCoursesModulesRelock {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/modules/{1}/relock" -f $CourseId, $Id 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   List module items 
.DESCRIPTION
   List the items in a module
.EXAMPLE
   PS C:> Get-CanvasCoursesModulesItems -CourseId $SomeCourseIdObj -ModuleId $SomeModuleIdObj -Include $SomeIncludeObj -search_term $Somesearch_termObj -student_id $Somestudent_idObj
#>
function Get-CanvasCoursesModulesItems {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The ModuleId
        [Parameter(Mandatory=$true)]
        $ModuleId,

        # If included, will return additional details specific to the content associated with each item. Refer to the Module Item specification for more details. Includes standard lock information for each item.
		#Allowed values: content_details 
        [Parameter(Mandatory=$false)]
        $Include,

        # The partial title of the items to match and return.
        [Parameter(Mandatory=$false)]
        $search_term,

        # Returns module completion information for the student with this id.
        [Parameter(Mandatory=$false)]
        $student_id
	)

    $uri = "/api/v1/courses/{0}/modules/{1}/items" -f $CourseId, $ModuleId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

	if ($search_term) {$Body["search_term"] = $search_term}

	if ($student_id) {$Body["student_id"] = $student_id}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Show module item 
.DESCRIPTION
   Get information about a single module item
.EXAMPLE
   PS C:> Get-CanvasCoursesModulesItems -CourseId $SomeCourseIdObj -ModuleId $SomeModuleIdObj -Id $SomeIdObj -Include $SomeIncludeObj -student_id $Somestudent_idObj
#>
function Get-CanvasCoursesModulesItems {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The ModuleId
        [Parameter(Mandatory=$true)]
        $ModuleId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # If included, will return additional details specific to the content associated with this item. Refer to the Module Item specification for more details. Includes standard lock information for each item.
		#Allowed values: content_details 
        [Parameter(Mandatory=$false)]
        $Include,

        # Returns module completion information for the student with this id.
        [Parameter(Mandatory=$false)]
        $student_id
	)

    $uri = "/api/v1/courses/{0}/modules/{1}/items/{2}" -f $CourseId, $ModuleId, $Id 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

	if ($student_id) {$Body["student_id"] = $student_id}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create a module item 
.DESCRIPTION
   Create and return a new module item
.EXAMPLE
   PS C:> Post-CanvasCoursesModulesItems -CourseId $SomeCourseIdObj -ModuleId $SomeModuleIdObj -Title $SomeTitleObj -Type $SomeTypeObj -ContentId $SomeContentIdObj -Position $SomePositionObj -Indent $SomeIndentObj -PageUrl $SomePageUrlObj -ExternalUrl $SomeExternalUrlObj -NewTab $SomeNewTabObj -Type $SomeTypeObj -MinScore $SomeMinScoreObj
#><#
function Post-CanvasCoursesModulesItems {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The ModuleId
        [Parameter(Mandatory=$true)]
        $ModuleId,

        # The name of the module item and associated content
        [Parameter(Mandatory=$false)]
        $Title,

        # The type of content linked to the item
		#Allowed values: File, Page, Discussion, Assignment, Quiz, SubHeader, ExternalUrl, ExternalTool 
        [Parameter(Mandatory=$true)]
        $Type,

        # The id of the content to link to the module item. Required, except for 'ExternalUrl', 'Page', and 'SubHeader' types.
        [Parameter(Mandatory=$true)]
        $ContentId,

        # The position of this item in the module (1-based).
        [Parameter(Mandatory=$false)]
        $Position,

        # 0-based indent level; module items may be indented to show a hierarchy
        [Parameter(Mandatory=$false)]
        $Indent,

        # Suffix for the linked wiki page (e.g. 'front-page'). Required for 'Page' type.
        [Parameter(Mandatory=$false)]
        $PageUrl,

        # External url that the item points to. [Required for 'ExternalUrl' and 'ExternalTool' types.
        [Parameter(Mandatory=$false)]
        $ExternalUrl,

        # Whether the external tool opens in a new tab. Only applies to 'ExternalTool' type.
        [Parameter(Mandatory=$false)]
        $NewTab,

        # Completion requirement for this module item. âmust_viewâ: Applies to all item types âmust_contributeâ: Only applies to âAssignmentâ, âDiscussionâ, and âPageâ types âmust_submitâ, âmin_scoreâ: Only apply to âAssignmentâ and âQuizâ types Inapplicable types will be ignored
		#Allowed values: must_view, must_contribute, must_submit 
        [Parameter(Mandatory=$false)]
        $Type,

        # Minimum score required to complete. Required for completion_requirement type 'min_score'.
        [Parameter(Mandatory=$false)]
        $MinScore
	)

    $uri = "/api/v1/courses/{0}/modules/{1}/items" -f $CourseId, $ModuleId 

	$Body = @{}

	if ($Title) {$Body["module_item[title]"] = $Title}

	$Body["module_item[type]"] = $Type

	$Body["module_item[content_id]"] = $ContentId

	if ($Position) {$Body["module_item[position]"] = $Position}

	if ($Indent) {$Body["module_item[indent]"] = $Indent}

	if ($PageUrl) {$Body["module_item[page_url]"] = $PageUrl}

	if ($ExternalUrl) {$Body["module_item[external_url]"] = $ExternalUrl}

	if ($NewTab) {$Body["module_item[new_tab]"] = $NewTab}

	if ($Type) {$Body["module_item[completion_requirement][type]"] = $Type}

	if ($MinScore) {$Body["module_item[completion_requirement][min_score]"] = $MinScore}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Update a module item 
.DESCRIPTION
   Update and return an existing module item
.EXAMPLE
   PS C:> Put-CanvasCoursesModulesItems -CourseId $SomeCourseIdObj -ModuleId $SomeModuleIdObj -Id $SomeIdObj -Title $SomeTitleObj -Position $SomePositionObj -Indent $SomeIndentObj -ExternalUrl $SomeExternalUrlObj -NewTab $SomeNewTabObj -Type $SomeTypeObj -MinScore $SomeMinScoreObj -Published $SomePublishedObj -ModuleId $SomeModuleIdObj
#><#
function Put-CanvasCoursesModulesItems {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The ModuleId
        [Parameter(Mandatory=$true)]
        $ModuleId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The name of the module item
        [Parameter(Mandatory=$false)]
        $Title,

        # The position of this item in the module (1-based)
        [Parameter(Mandatory=$false)]
        $Position,

        # 0-based indent level; module items may be indented to show a hierarchy
        [Parameter(Mandatory=$false)]
        $Indent,

        # External url that the item points to. Only applies to 'ExternalUrl' type.
        [Parameter(Mandatory=$false)]
        $ExternalUrl,

        # Whether the external tool opens in a new tab. Only applies to 'ExternalTool' type.
        [Parameter(Mandatory=$false)]
        $NewTab,

        # Completion requirement for this module item. âmust_viewâ: Applies to all item types âmust_contributeâ: Only applies to âAssignmentâ, âDiscussionâ, and âPageâ types âmust_submitâ, âmin_scoreâ: Only apply to âAssignmentâ and âQuizâ types Inapplicable types will be ignored
		#Allowed values: must_view, must_contribute, must_submit 
        [Parameter(Mandatory=$false)]
        $Type,

        # Minimum score required to complete, Required for completion_requirement type 'min_score'.
        [Parameter(Mandatory=$false)]
        $MinScore,

        # Whether the module item is published and visible to students.
        [Parameter(Mandatory=$false)]
        $Published,

        # Move this item to another module by specifying the target module id here. The target module must be in the same course.
        [Parameter(Mandatory=$false)]
        $ModuleId
	)

    $uri = "/api/v1/courses/{0}/modules/{1}/items/{2}" -f $CourseId, $ModuleId, $Id 

	$Body = @{}

	if ($Title) {$Body["module_item[title]"] = $Title}

	if ($Position) {$Body["module_item[position]"] = $Position}

	if ($Indent) {$Body["module_item[indent]"] = $Indent}

	if ($ExternalUrl) {$Body["module_item[external_url]"] = $ExternalUrl}

	if ($NewTab) {$Body["module_item[new_tab]"] = $NewTab}

	if ($Type) {$Body["module_item[completion_requirement][type]"] = $Type}

	if ($MinScore) {$Body["module_item[completion_requirement][min_score]"] = $MinScore}

	if ($Published) {$Body["module_item[published]"] = $Published}

	if ($ModuleId) {$Body["module_item[module_id]"] = $ModuleId}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}
#>

<#
.Synopsis
   Select a mastery path 
.DESCRIPTION
   Select a mastery path when module item includes several possible paths. Requires Mastery Paths feature to be enabled. Returns a compound document with the assignments included in the given path and any module items related to those assignments
.EXAMPLE
   PS C:> Post-CanvasCoursesModulesItemsSelectMasteryPath -CourseId $SomeCourseIdObj -ModuleId $SomeModuleIdObj -Id $SomeIdObj -assignment_set_id $Someassignment_set_idObj -student_id $Somestudent_idObj
#>
function Post-CanvasCoursesModulesItemsSelectMasteryPath {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The ModuleId
        [Parameter(Mandatory=$true)]
        $ModuleId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Assignment set chosen, as specified in the mastery_paths portion of the context module item response
        [Parameter(Mandatory=$false)]
        $assignment_set_id,

        # Which student the selection applies to. If not specified, current user is implied.
        [Parameter(Mandatory=$false)]
        $student_id
	)

    $uri = "/api/v1/courses/{0}/modules/{1}/items/{2}/select_mastery_path" -f $CourseId, $ModuleId, $Id 

	$Body = @{}

	if ($assignment_set_id) {$Body["assignment_set_id"] = $assignment_set_id}

	if ($student_id) {$Body["student_id"] = $student_id}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Delete module item 
.DESCRIPTION
   Delete a module item
.EXAMPLE
   PS C:> Delete-CanvasCoursesModulesItems -CourseId $SomeCourseIdObj -ModuleId $SomeModuleIdObj -Id $SomeIdObj
#>
function Delete-CanvasCoursesModulesItems {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The ModuleId
        [Parameter(Mandatory=$true)]
        $ModuleId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/modules/{1}/items/{2}" -f $CourseId, $ModuleId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Mark module item as done/not done 
.DESCRIPTION
   Mark a module item as done/not done. Use HTTP method PUT to mark as done, and DELETE to mark as not done.
.EXAMPLE
   PS C:> Put-CanvasCoursesModulesItemsDone -CourseId $SomeCourseIdObj -ModuleId $SomeModuleIdObj -Id $SomeIdObj
#>
function Put-CanvasCoursesModulesItemsDone {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The ModuleId
        [Parameter(Mandatory=$true)]
        $ModuleId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/modules/{1}/items/{2}/done" -f $CourseId, $ModuleId, $Id 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Get module item sequence 
.DESCRIPTION
   Given an asset in a course, find the ModuleItem it belongs to, and also the previous and next Module Items in the course sequence.
.EXAMPLE
   PS C:> Get-CanvasCoursesModuleItemSequence -CourseId $SomeCourseIdObj -asset_type $Someasset_typeObj -asset_id $Someasset_idObj
#>
function Get-CanvasCoursesModuleItemSequence {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The type of asset to find module sequence information for. Use the ModuleItem if it is known (e.g., the user navigated from a module item), since this will avoid ambiguity if the asset appears more than once in the module sequence.
		#Allowed values: ModuleItem, File, Page, Discussion, Assignment, Quiz, ExternalTool 
        [Parameter(Mandatory=$false)]
        $asset_type,

        # The id of the asset (or the url in the case of a Page)
        [Parameter(Mandatory=$false)]
        $asset_id
	)

    $uri = "/api/v1/courses/{0}/module_item_sequence" -f $CourseId 

	$Body = @{}

	if ($asset_type) {$Body["asset_type"] = $asset_type}

	if ($asset_id) {$Body["asset_id"] = $asset_id}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Mark module item read 
.DESCRIPTION
   Fulfills âmust viewâ requirement for a module item. It is generally not necessary to do this explicitly, but it is provided for applications that need to access external content directly (bypassing the html_url redirect that normally allows Canvas to fulfill âmust viewâ requirements). This endpoint cannot be used to complete requirements on locked or unpublished module items.
.EXAMPLE
   PS C:> Post-CanvasCoursesModulesItemsMarkRead -CourseId $SomeCourseIdObj -ModuleId $SomeModuleIdObj -Id $SomeIdObj
#>
function Post-CanvasCoursesModulesItemsMarkRead {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The ModuleId
        [Parameter(Mandatory=$true)]
        $ModuleId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/modules/{1}/items/{2}/mark_read" -f $CourseId, $ModuleId, $Id 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   List preferences 
.DESCRIPTION
   Fetch all preferences for the given communication channel
.EXAMPLE
   PS C:> Get-CanvasUsersCommunicationChannelsNotificationPreferences -UserId $SomeUserIdObj -CommunicationChannelId $SomeCommunicationChannelIdObj
#>
function Get-CanvasUsersCommunicationChannelsNotificationPreferences {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The CommunicationChannelId
        [Parameter(Mandatory=$true)]
        $CommunicationChannelId
	)

    $uri = "/api/v1/users/{0}/communication_channels/{1}/notification_preferences" -f $UserId, $CommunicationChannelId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List of preference categories 
.DESCRIPTION
   Fetch all notification preference categories for the given communication channel
.EXAMPLE
   PS C:> Get-CanvasUsersCommunicationChannelsNotificationPreferenceCategories -UserId $SomeUserIdObj -CommunicationChannelId $SomeCommunicationChannelIdObj
#>
function Get-CanvasUsersCommunicationChannelsNotificationPreferenceCategories {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The CommunicationChannelId
        [Parameter(Mandatory=$true)]
        $CommunicationChannelId
	)

    $uri = "/api/v1/users/{0}/communication_channels/{1}/notification_preference_categories" -f $UserId, $CommunicationChannelId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get a preference 
.DESCRIPTION
   Fetch the preference for the given notification for the given communicaiton channel
.EXAMPLE
   PS C:> Get-CanvasUsersCommunicationChannelsNotificationPreferences -UserId $SomeUserIdObj -CommunicationChannelId $SomeCommunicationChannelIdObj -Notification $SomeNotificationObj
#>
function Get-CanvasUsersCommunicationChannelsNotificationPreferences {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The CommunicationChannelId
        [Parameter(Mandatory=$true)]
        $CommunicationChannelId,

        # The Notification
        [Parameter(Mandatory=$true)]
        $Notification
	)

    $uri = "/api/v1/users/{0}/communication_channels/{1}/notification_preferences/{2}" -f $UserId, $CommunicationChannelId, $Notification 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Update a preference 
.DESCRIPTION
   Change the preference for a single notification for a single communication channel
.EXAMPLE
   PS C:> Put-CanvasUsersSelfCommunicationChannelsNotificationPreferences -CommunicationChannelId $SomeCommunicationChannelIdObj -Notification $SomeNotificationObj -Frequency $SomeFrequencyObj
#>
function Put-CanvasUsersSelfCommunicationChannelsNotificationPreferences {
[CmdletBinding()]

	Param
	(
        # The CommunicationChannelId
        [Parameter(Mandatory=$true)]
        $CommunicationChannelId,

        # The Notification
        [Parameter(Mandatory=$true)]
        $Notification,

        # The desired frequency for this notification
        [Parameter(Mandatory=$true)]
        $Frequency
	)

    $uri = "/api/v1/users/self/communication_channels/{0}/notification_preferences/{1}" -f $CommunicationChannelId, $Notification 

	$Body = @{}

	$Body["notification_preferences[frequency]"] = $Frequency

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Update preferences by category 
.DESCRIPTION
   Change the preferences for multiple notifications based on the category for a single communication channel
.EXAMPLE
   PS C:> Put-CanvasUsersSelfCommunicationChannelsNotificationPreferenceCategories -CommunicationChannelId $SomeCommunicationChannelIdObj -Category $SomeCategoryObj -category $SomecategoryObj -Frequency $SomeFrequencyObj
#><#
function Put-CanvasUsersSelfCommunicationChannelsNotificationPreferenceCategories {
[CmdletBinding()]

	Param
	(
        # The CommunicationChannelId
        [Parameter(Mandatory=$true)]
        $CommunicationChannelId,

        # The Category
        [Parameter(Mandatory=$true)]
        $Category,

        # The name of the category. Must be parameterized (e.g. The category âCourse Contentâ should be âcourse_contentâ)
        [Parameter(Mandatory=$false)]
        $category,

        # The desired frequency for each notification in the category
        [Parameter(Mandatory=$true)]
        $Frequency
	)

    $uri = "/api/v1/users/self/communication_channels/{0}/notification_preference_categories/{1}" -f $CommunicationChannelId, $Category 

	$Body = @{}

	if ($category) {$Body["category"] = $category}

	$Body["notification_preferences[frequency]"] = $Frequency

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}
#>

<#
.Synopsis
   Update multiple preferences 
.DESCRIPTION
   Change the preferences for multiple notifications for a single communication channel at once
.EXAMPLE
   PS C:> Put-CanvasUsersSelfCommunicationChannelsNotificationPreferences -CommunicationChannelId $SomeCommunicationChannelIdObj -Frequency $SomeFrequencyObj
#>
function Put-CanvasUsersSelfCommunicationChannelsNotificationPreferences {
[CmdletBinding()]

	Param
	(
        # The CommunicationChannelId
        [Parameter(Mandatory=$true)]
        $CommunicationChannelId,

        # The desired frequency for <X> notification
        [Parameter(Mandatory=$true)]
        $Frequency
	)

    $uri = "/api/v1/users/self/communication_channels/{0}/notification_preferences" -f $CommunicationChannelId 

	$Body = @{}

	$Body["notification_preferences[<X>][frequency]"] = $Frequency

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Redirect to root outcome group for context 
.DESCRIPTION
   Convenience redirect to find the root outcome group for a particular context. Will redirect to the appropriate outcome group's URL.
.EXAMPLE
   PS C:> Get-CanvasGlobalRootOutcomeGroup
#><#
function Get-CanvasGlobalRootOutcomeGroup {
[CmdletBinding()]

    $uri = "/api/v1/global/root_outcome_group" 

    return Get-CanvasApiResult $uri -Method GET
}
#>

<#
.Synopsis
   Get all outcome groups for context 
.DESCRIPTION
   
.EXAMPLE
   PS C:> Get-CanvasAccountsOutcomeGroups -AccountId $SomeAccountIdObj
#>
function Get-CanvasAccountsOutcomeGroups {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId
	)

    $uri = "/api/v1/accounts/{0}/outcome_groups" -f $AccountId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get all outcome links for context 
.DESCRIPTION
   
.EXAMPLE
   PS C:> Get-CanvasAccountsOutcomeGroupLinks -AccountId $SomeAccountIdObj
#>
function Get-CanvasAccountsOutcomeGroupLinks {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId
	)

    $uri = "/api/v1/accounts/{0}/outcome_group_links" -f $AccountId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Show an outcome group 
.DESCRIPTION
   
.EXAMPLE
   PS C:> Get-CanvasGlobalOutcomeGroups -Id $SomeIdObj
#>
function Get-CanvasGlobalOutcomeGroups {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/global/outcome_groups/{0}" -f $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Update an outcome group 
.DESCRIPTION
   Modify an existing outcome group. Fields not provided are left as is; unrecognized fields are ignored. When changing the parent outcome group, the new parent group must belong to the same context as this outcome group, and must not be a descendant of this outcome group (i.e. no cycles allowed).
.EXAMPLE
   PS C:> Put-CanvasGlobalOutcomeGroups -Id $SomeIdObj -title $SometitleObj -description $SomedescriptionObj -vendor_guid $Somevendor_guidObj -parent_outcome_group_id $Someparent_outcome_group_idObj
#>
function Put-CanvasGlobalOutcomeGroups {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The new outcome group title.
        [Parameter(Mandatory=$false)]
        $title,

        # The new outcome group description.
        [Parameter(Mandatory=$false)]
        $description,

        # A custom GUID for the learning standard.
        [Parameter(Mandatory=$false)]
        $vendor_guid,

        # The id of the new parent outcome group.
        [Parameter(Mandatory=$false)]
        $parent_outcome_group_id
	)

    $uri = "/api/v1/global/outcome_groups/{0}" -f $Id 

	$Body = @{}

	if ($title) {$Body["title"] = $title}

	if ($description) {$Body["description"] = $description}

	if ($vendor_guid) {$Body["vendor_guid"] = $vendor_guid}

	if ($parent_outcome_group_id) {$Body["parent_outcome_group_id"] = $parent_outcome_group_id}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Delete an outcome group 
.DESCRIPTION
   Deleting an outcome group deletes descendant outcome groups and outcome links. The linked outcomes themselves are only deleted if all links to the outcome were deleted. Aligned outcomes cannot be deleted; as such, if all remaining links to an aligned outcome are included in this group's descendants, the group deletion will fail.
.EXAMPLE
   PS C:> Delete-CanvasGlobalOutcomeGroups -Id $SomeIdObj
#>
function Delete-CanvasGlobalOutcomeGroups {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/global/outcome_groups/{0}" -f $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   List linked outcomes 
.DESCRIPTION
   List the immediate OutcomeLink children of the outcome group. Paginated.
.EXAMPLE
   PS C:> Get-CanvasGlobalOutcomeGroupsOutcomes -Id $SomeIdObj -outcome_style $Someoutcome_styleObj
#>
function Get-CanvasGlobalOutcomeGroupsOutcomes {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The detail level of the outcomes. Defaults to âabbrevâ. Specify âfullâ for more information.
        [Parameter(Mandatory=$false)]
        $outcome_style
	)

    $uri = "/api/v1/global/outcome_groups/{0}/outcomes" -f $Id 

	$Body = @{}

	if ($outcome_style) {$Body["outcome_style"] = $outcome_style}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create/link an outcome 
.DESCRIPTION
   Link an outcome into the outcome group. The outcome to link can either be specified by a PUT to the link URL for a specific outcome (the outcome_id in the PUT URLs) or by supplying the information for a new outcome (title, description, ratings, mastery_points) in a POST to the collection. If linking an existing outcome, the outcome_id must identify an outcome available to this context; i.e. an outcome owned by this group's context, an outcome owned by an associated account, or a global outcome. With outcome_id present, any other parameters are ignored. If defining a new outcome, the outcome is created in the outcome group's context using the provided title, description, ratings, and mastery points; the title is required but all other fields are optional. The new outcome is then linked into the outcome group. If ratings are provided when creating a new outcome, an embedded rubric criterion is included in the new outcome. This criterion's mastery_points default to the maximum points in the highest rating if not specified in the mastery_points parameter. Any ratings lacking a description are given a default of âNo descriptionâ. Any ratings lacking a point value are given a default of 0. If no ratings are provided, the mastery_points parameter is ignored.
.EXAMPLE
   PS C:> Post-CanvasGlobalOutcomeGroupsOutcomes -Id $SomeIdObj -outcome_id $Someoutcome_idObj -title $SometitleObj -display_name $Somedisplay_nameObj -description $SomedescriptionObj -vendor_guid $Somevendor_guidObj -mastery_points $Somemastery_pointsObj -Ratings[Description] $SomeRatings[Description]Obj -Ratings[Points] $SomeRatings[Points]Obj -calculation_method $Somecalculation_methodObj -calculation_int $Somecalculation_intObj
#><#
function Post-CanvasGlobalOutcomeGroupsOutcomes {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The ID of the existing outcome to link.
        [Parameter(Mandatory=$false)]
        $outcome_id,

        # The title of the new outcome. Required if outcome_id is absent.
        [Parameter(Mandatory=$false)]
        $title,

        # A friendly name shown in reports for outcomes with cryptic titles, such as common core standards names.
        [Parameter(Mandatory=$false)]
        $display_name,

        # The description of the new outcome.
        [Parameter(Mandatory=$false)]
        $description,

        # A custom GUID for the learning standard.
        [Parameter(Mandatory=$false)]
        $vendor_guid,

        # The mastery threshold for the embedded rubric criterion.
        [Parameter(Mandatory=$false)]
        $mastery_points,

        # The description of a rating level for the embedded rubric criterion.
        [Parameter(Mandatory=$false)]
        $Ratings[Description],

        # The points corresponding to a rating level for the embedded rubric criterion.
        [Parameter(Mandatory=$false)]
        $Ratings[Points],

        # The new calculation method. Defaults to âhighestâ
		#Allowed values: decaying_average, n_mastery, latest, highest 
        [Parameter(Mandatory=$false)]
        $calculation_method,

        # The new calculation int. Only applies if the calculation_method is âdecaying_averageâ or ân_masteryâ
        [Parameter(Mandatory=$false)]
        $calculation_int
	)

    $uri = "/api/v1/global/outcome_groups/{0}/outcomes" -f $Id 

	$Body = @{}

	if ($outcome_id) {$Body["outcome_id"] = $outcome_id}

	if ($title) {$Body["title"] = $title}

	if ($display_name) {$Body["display_name"] = $display_name}

	if ($description) {$Body["description"] = $description}

	if ($vendor_guid) {$Body["vendor_guid"] = $vendor_guid}

	if ($mastery_points) {$Body["mastery_points"] = $mastery_points}

	if ($Ratings[Description]) {$Body["ratings[][description]"] = $Ratings[Description]}

	if ($Ratings[Points]) {$Body["ratings[][points]"] = $Ratings[Points]}

	if ($calculation_method) {$Body["calculation_method"] = $calculation_method}

	if ($calculation_int) {$Body["calculation_int"] = $calculation_int}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Unlink an outcome 
.DESCRIPTION
   Unlinking an outcome only deletes the outcome itself if this was the last link to the outcome in any group in any context. Aligned outcomes cannot be deleted; as such, if this is the last link to an aligned outcome, the unlinking will fail.
.EXAMPLE
   PS C:> Delete-CanvasGlobalOutcomeGroupsOutcomes -Id $SomeIdObj -OutcomeId $SomeOutcomeIdObj
#>
function Delete-CanvasGlobalOutcomeGroupsOutcomes {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The OutcomeId
        [Parameter(Mandatory=$true)]
        $OutcomeId
	)

    $uri = "/api/v1/global/outcome_groups/{0}/outcomes/{1}" -f $Id, $OutcomeId 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   List subgroups 
.DESCRIPTION
   List the immediate OutcomeGroup children of the outcome group. Paginated.
.EXAMPLE
   PS C:> Get-CanvasGlobalOutcomeGroupsSubgroups -Id $SomeIdObj
#>
function Get-CanvasGlobalOutcomeGroupsSubgroups {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/global/outcome_groups/{0}/subgroups" -f $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create a subgroup 
.DESCRIPTION
   Creates a new empty subgroup under the outcome group with the given title and description.
.EXAMPLE
   PS C:> Post-CanvasGlobalOutcomeGroupsSubgroups -Id $SomeIdObj -title $SometitleObj -description $SomedescriptionObj -vendor_guid $Somevendor_guidObj
#>
function Post-CanvasGlobalOutcomeGroupsSubgroups {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The title of the new outcome group.
        [Parameter(Mandatory=$true)]
        $title,

        # The description of the new outcome group.
        [Parameter(Mandatory=$false)]
        $description,

        # A custom GUID for the learning standard
        [Parameter(Mandatory=$false)]
        $vendor_guid
	)

    $uri = "/api/v1/global/outcome_groups/{0}/subgroups" -f $Id 

	$Body = @{}

	$Body["title"] = $title

	if ($description) {$Body["description"] = $description}

	if ($vendor_guid) {$Body["vendor_guid"] = $vendor_guid}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Import an outcome group 
.DESCRIPTION
   Creates a new subgroup of the outcome group with the same title and description as the source group, then creates links in that new subgroup to the same outcomes that are linked in the source group. Recurses on the subgroups of the source group, importing them each in turn into the new subgroup. Allows you to copy organizational structure, but does not create copies of the outcomes themselves, only new links. The source group must be either global, from the same context as this outcome group, or from an associated account. The source group cannot be the root outcome group of its context.
.EXAMPLE
   PS C:> Post-CanvasGlobalOutcomeGroupsImport -Id $SomeIdObj -source_outcome_group_id $Somesource_outcome_group_idObj
#>
function Post-CanvasGlobalOutcomeGroupsImport {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The ID of the source outcome group.
        [Parameter(Mandatory=$true)]
        $source_outcome_group_id
	)

    $uri = "/api/v1/global/outcome_groups/{0}/import" -f $Id 

	$Body = @{}

	$Body["source_outcome_group_id"] = $source_outcome_group_id

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Get outcome results 
.DESCRIPTION
   Gets the outcome results for users and outcomes in the specified context.
.EXAMPLE
   PS C:> Get-CanvasCoursesOutcomeResults -CourseId $SomeCourseIdObj -UserIds $SomeUserIdsObj -OutcomeIds $SomeOutcomeIdsObj -Include $SomeIncludeObj
#>
function Get-CanvasCoursesOutcomeResults {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # If specified, only the users whose ids are given will be included in the results. SIS ids can be used, prefixed by âsis_user_id:â. It is an error to specify an id for a user who is not a student in the context.
        [Parameter(Mandatory=$false)]
        $UserIds,

        # If specified, only the outcomes whose ids are given will be included in the results. it is an error to specify an id for an outcome which is not linked to the context.
        [Parameter(Mandatory=$false)]
        $OutcomeIds,

        # String, âalignmentsâ|âoutcomesâ|âoutcomes.alignmentsâ|âoutcome_groupsâ|âoutcome_linksâ|âoutcome_pathsâ|âusersâ 
		#Specify additional collections to be side loaded with the result. âalignmentsâ includes only the alignments referenced by the returned results. âoutcomes.alignmentsâ includes all alignments referenced by outcomes in the context.
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/courses/{0}/outcome_results" -f $CourseId 

	$Body = @{}

	if ($UserIds) {$Body["user_ids[]"] = $UserIds}

	if ($OutcomeIds) {$Body["outcome_ids[]"] = $OutcomeIds}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get outcome result rollups 
.DESCRIPTION
   Gets the outcome rollups for the users and outcomes in the specified context.
.EXAMPLE
   PS C:> Get-CanvasCoursesOutcomeRollups -CourseId $SomeCourseIdObj -aggregate $SomeaggregateObj -UserIds $SomeUserIdsObj -OutcomeIds $SomeOutcomeIdsObj -Include $SomeIncludeObj
#>
function Get-CanvasCoursesOutcomeRollups {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # If specified, instead of returning one rollup for each user, all the user rollups will be combined into one rollup for the course that will contain the average rollup score for each outcome.
		#Allowed values: course 
        [Parameter(Mandatory=$false)]
        $aggregate,

        # If specified, only the users whose ids are given will be included in the results or used in an aggregate result. it is an error to specify an id for a user who is not a student in the context
        [Parameter(Mandatory=$false)]
        $UserIds,

        # If specified, only the outcomes whose ids are given will be included in the results. it is an error to specify an id for an outcome which is not linked to the context.
        [Parameter(Mandatory=$false)]
        $OutcomeIds,

        # String, âcoursesâ|âoutcomesâ|âoutcomes.alignmentsâ|âoutcome_groupsâ|âoutcome_linksâ|âoutcome_pathsâ|âusersâ 
		#Specify additional collections to be side loaded with the result.
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/courses/{0}/outcome_rollups" -f $CourseId 

	$Body = @{}

	if ($aggregate) {$Body["aggregate"] = $aggregate}

	if ($UserIds) {$Body["user_ids[]"] = $UserIds}

	if ($OutcomeIds) {$Body["outcome_ids[]"] = $OutcomeIds}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Show an outcome 
.DESCRIPTION
   Returns the details of the outcome with the given id.
.EXAMPLE
   PS C:> Get-CanvasOutcomes -Id $SomeIdObj
#>
function Get-CanvasOutcomes {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/outcomes/{0}" -f $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Update an outcome 
.DESCRIPTION
   Modify an existing outcome. Fields not provided are left as is; unrecognized fields are ignored. If any new ratings are provided, the combination of all new ratings provided completely replace any existing embedded rubric criterion; it is not possible to tweak the ratings of the embedded rubric criterion. A new embedded rubric criterion's mastery_points default to the maximum points in the highest rating if not specified in the mastery_points parameter. Any new ratings lacking a description are given a default of âNo descriptionâ. Any new ratings lacking a point value are given a default of 0.
.EXAMPLE
   PS C:> Put-CanvasOutcomes -Id $SomeIdObj -title $SometitleObj -display_name $Somedisplay_nameObj -description $SomedescriptionObj -vendor_guid $Somevendor_guidObj -mastery_points $Somemastery_pointsObj -Ratings[Description] $SomeRatings[Description]Obj -Ratings[Points] $SomeRatings[Points]Obj -calculation_method $Somecalculation_methodObj -calculation_int $Somecalculation_intObj
#><#
function Put-CanvasOutcomes {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The new outcome title.
        [Parameter(Mandatory=$false)]
        $title,

        # A friendly name shown in reports for outcomes with cryptic titles, such as common core standards names.
        [Parameter(Mandatory=$false)]
        $display_name,

        # The new outcome description.
        [Parameter(Mandatory=$false)]
        $description,

        # A custom GUID for the learning standard.
        [Parameter(Mandatory=$false)]
        $vendor_guid,

        # The new mastery threshold for the embedded rubric criterion.
        [Parameter(Mandatory=$false)]
        $mastery_points,

        # The description of a new rating level for the embedded rubric criterion.
        [Parameter(Mandatory=$false)]
        $Ratings[Description],

        # The points corresponding to a new rating level for the embedded rubric criterion.
        [Parameter(Mandatory=$false)]
        $Ratings[Points],

        # The new calculation method.
		#Allowed values: decaying_average, n_mastery, latest, highest 
        [Parameter(Mandatory=$false)]
        $calculation_method,

        # The new calculation int. Only applies if the calculation_method is âdecaying_averageâ or ân_masteryâ
        [Parameter(Mandatory=$false)]
        $calculation_int
	)

    $uri = "/api/v1/outcomes/{0}" -f $Id 

	$Body = @{}

	if ($title) {$Body["title"] = $title}

	if ($display_name) {$Body["display_name"] = $display_name}

	if ($description) {$Body["description"] = $description}

	if ($vendor_guid) {$Body["vendor_guid"] = $vendor_guid}

	if ($mastery_points) {$Body["mastery_points"] = $mastery_points}

	if ($Ratings[Description]) {$Body["ratings[][description]"] = $Ratings[Description]}

	if ($Ratings[Points]) {$Body["ratings[][points]"] = $Ratings[Points]}

	if ($calculation_method) {$Body["calculation_method"] = $calculation_method}

	if ($calculation_int) {$Body["calculation_int"] = $calculation_int}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}
#>

<#
.Synopsis
   Show front page 
.DESCRIPTION
   Retrieve the content of the front page
.EXAMPLE
   PS C:> Get-CanvasCoursesFrontPage -CourseId $SomeCourseIdObj
#>
function Get-CanvasCoursesFrontPage {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/front_page" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Update/create front page 
.DESCRIPTION
   Update the title or contents of the front page
.EXAMPLE
   PS C:> Put-CanvasCoursesFrontPage -CourseId $SomeCourseIdObj -Title $SomeTitleObj -Body $SomeBodyObj -EditingRoles $SomeEditingRolesObj -NotifyOfUpdate $SomeNotifyOfUpdateObj -Published $SomePublishedObj
#>
function Put-CanvasCoursesFrontPage {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The title for the new page. NOTE: changing a page's title will change its url. The updated url will be returned in the result.
        [Parameter(Mandatory=$false)]
        $Title,

        # The content for the new page.
        [Parameter(Mandatory=$false)]
        $Body,

        # Which user roles are allowed to edit this page. Any combination of these roles is allowed (separated by commas).
		#âteachersâ 
		#Allows editing by teachers in the course.
		#âstudentsâ 
		#Allows editing by students in the course.
		#âmembersâ 
		#For group wikis, allows editing by members of the group.
		#âpublicâ 
		#Allows editing by any user.
		#Allowed values: teachers, students, members, public 
        [Parameter(Mandatory=$false)]
        $EditingRoles,

        # Whether participants should be notified when this page changes.
        [Parameter(Mandatory=$false)]
        $NotifyOfUpdate,

        # Whether the page is published (true) or draft state (false).
        [Parameter(Mandatory=$false)]
        $Published
	)

    $uri = "/api/v1/courses/{0}/front_page" -f $CourseId 

	$Body = @{}

	if ($Title) {$Body["wiki_page[title]"] = $Title}

	if ($Body) {$Body["wiki_page[body]"] = $Body}

	if ($EditingRoles) {$Body["wiki_page[editing_roles]"] = $EditingRoles}

	if ($NotifyOfUpdate) {$Body["wiki_page[notify_of_update]"] = $NotifyOfUpdate}

	if ($Published) {$Body["wiki_page[published]"] = $Published}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   List pages 
.DESCRIPTION
   List the wiki pages associated with a course or group
.EXAMPLE
   PS C:> Get-CanvasCoursesPages -CourseId $SomeCourseIdObj -sort $SomesortObj -order $SomeorderObj -search_term $Somesearch_termObj -published $SomepublishedObj
#>
function Get-CanvasCoursesPages {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # Sort results by this field.
		#Allowed values: title, created_at, updated_at 
        [Parameter(Mandatory=$false)]
        $sort,

        # The sorting order. Defaults to 'asc'.
		#Allowed values: asc, desc 
        [Parameter(Mandatory=$false)]
        $order,

        # The partial title of the pages to match and return.
        [Parameter(Mandatory=$false)]
        $search_term,

        # If true, include only published paqes. If false, exclude published pages. If not present, do not filter on published status.
        [Parameter(Mandatory=$false)]
        $published
	)

    $uri = "/api/v1/courses/{0}/pages" -f $CourseId 

	$Body = @{}

	if ($sort) {$Body["sort"] = $sort}

	if ($order) {$Body["order"] = $order}

	if ($search_term) {$Body["search_term"] = $search_term}

	if ($published) {$Body["published"] = $published}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create page 
.DESCRIPTION
   Create a new wiki page
.EXAMPLE
   PS C:> Post-CanvasCoursesPages -CourseId $SomeCourseIdObj -Title $SomeTitleObj -Body $SomeBodyObj -EditingRoles $SomeEditingRolesObj -NotifyOfUpdate $SomeNotifyOfUpdateObj -Published $SomePublishedObj -FrontPage $SomeFrontPageObj
#>
function Post-CanvasCoursesPages {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The title for the new page.
        [Parameter(Mandatory=$true)]
        $Title,

        # The content for the new page.
        [Parameter(Mandatory=$false)]
        $Body,

        # Which user roles are allowed to edit this page. Any combination of these roles is allowed (separated by commas).
		#âteachersâ 
		#Allows editing by teachers in the course.
		#âstudentsâ 
		#Allows editing by students in the course.
		#âmembersâ 
		#For group wikis, allows editing by members of the group.
		#âpublicâ 
		#Allows editing by any user.
		#Allowed values: teachers, students, members, public 
        [Parameter(Mandatory=$false)]
        $EditingRoles,

        # Whether participants should be notified when this page changes.
        [Parameter(Mandatory=$false)]
        $NotifyOfUpdate,

        # Whether the page is published (true) or draft state (false).
        [Parameter(Mandatory=$false)]
        $Published,

        # Set an unhidden page as the front page (if true)
        [Parameter(Mandatory=$false)]
        $FrontPage
	)

    $uri = "/api/v1/courses/{0}/pages" -f $CourseId 

	$Body = @{}

	$Body["wiki_page[title]"] = $Title

	if ($Body) {$Body["wiki_page[body]"] = $Body}

	if ($EditingRoles) {$Body["wiki_page[editing_roles]"] = $EditingRoles}

	if ($NotifyOfUpdate) {$Body["wiki_page[notify_of_update]"] = $NotifyOfUpdate}

	if ($Published) {$Body["wiki_page[published]"] = $Published}

	if ($FrontPage) {$Body["wiki_page[front_page]"] = $FrontPage}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Show page 
.DESCRIPTION
   Retrieve the content of a wiki page
.EXAMPLE
   PS C:> Get-CanvasCoursesPages -CourseId $SomeCourseIdObj -Url $SomeUrlObj
#>
function Get-CanvasCoursesPages {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Url
        [Parameter(Mandatory=$true)]
        $Url
	)

    $uri = "/api/v1/courses/{0}/pages/{1}" -f $CourseId, $Url 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Update/create page 
.DESCRIPTION
   Update the title or contents of a wiki page
.EXAMPLE
   PS C:> Put-CanvasCoursesPages -CourseId $SomeCourseIdObj -Url $SomeUrlObj -Title $SomeTitleObj -Body $SomeBodyObj -EditingRoles $SomeEditingRolesObj -NotifyOfUpdate $SomeNotifyOfUpdateObj -Published $SomePublishedObj -FrontPage $SomeFrontPageObj
#>
function Put-CanvasCoursesPages {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Url
        [Parameter(Mandatory=$true)]
        $Url,

        # The title for the new page. NOTE: changing a page's title will change its url. The updated url will be returned in the result.
        [Parameter(Mandatory=$false)]
        $Title,

        # The content for the new page.
        [Parameter(Mandatory=$false)]
        $Body,

        # Which user roles are allowed to edit this page. Any combination of these roles is allowed (separated by commas).
		#âteachersâ 
		#Allows editing by teachers in the course.
		#âstudentsâ 
		#Allows editing by students in the course.
		#âmembersâ 
		#For group wikis, allows editing by members of the group.
		#âpublicâ 
		#Allows editing by any user.
		#Allowed values: teachers, students, members, public 
        [Parameter(Mandatory=$false)]
        $EditingRoles,

        # Whether participants should be notified when this page changes.
        [Parameter(Mandatory=$false)]
        $NotifyOfUpdate,

        # Whether the page is published (true) or draft state (false).
        [Parameter(Mandatory=$false)]
        $Published,

        # Set an unhidden page as the front page (if true)
        [Parameter(Mandatory=$false)]
        $FrontPage
	)

    $uri = "/api/v1/courses/{0}/pages/{1}" -f $CourseId, $Url 

	$Body = @{}

	if ($Title) {$Body["wiki_page[title]"] = $Title}

	if ($Body) {$Body["wiki_page[body]"] = $Body}

	if ($EditingRoles) {$Body["wiki_page[editing_roles]"] = $EditingRoles}

	if ($NotifyOfUpdate) {$Body["wiki_page[notify_of_update]"] = $NotifyOfUpdate}

	if ($Published) {$Body["wiki_page[published]"] = $Published}

	if ($FrontPage) {$Body["wiki_page[front_page]"] = $FrontPage}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Delete page 
.DESCRIPTION
   Delete a wiki page
.EXAMPLE
   PS C:> Delete-CanvasCoursesPages -CourseId $SomeCourseIdObj -Url $SomeUrlObj
#>
function Delete-CanvasCoursesPages {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Url
        [Parameter(Mandatory=$true)]
        $Url
	)

    $uri = "/api/v1/courses/{0}/pages/{1}" -f $CourseId, $Url 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   List revisions 
.DESCRIPTION
   List the revisions of a page. Callers must have update rights on the page in order to see page history.
.EXAMPLE
   PS C:> Get-CanvasCoursesPagesRevisions -CourseId $SomeCourseIdObj -Url $SomeUrlObj
#>
function Get-CanvasCoursesPagesRevisions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Url
        [Parameter(Mandatory=$true)]
        $Url
	)

    $uri = "/api/v1/courses/{0}/pages/{1}/revisions" -f $CourseId, $Url 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Show revision 
.DESCRIPTION
   Retrieve the metadata and optionally content of a revision of the page. Note that retrieving historic versions of pages requires edit rights.
.EXAMPLE
   PS C:> Get-CanvasCoursesPagesRevisionsLatest -CourseId $SomeCourseIdObj -Url $SomeUrlObj -summary $SomesummaryObj
#>
function Get-CanvasCoursesPagesRevisionsLatest {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Url
        [Parameter(Mandatory=$true)]
        $Url,

        # If set, exclude page content from results
        [Parameter(Mandatory=$false)]
        $summary
	)

    $uri = "/api/v1/courses/{0}/pages/{1}/revisions/latest" -f $CourseId, $Url 

	$Body = @{}

	if ($summary) {$Body["summary"] = $summary}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Revert to revision 
.DESCRIPTION
   Revert a page to a prior revision.
.EXAMPLE
   PS C:> Post-CanvasCoursesPagesRevisions -CourseId $SomeCourseIdObj -Url $SomeUrlObj -RevisionId $SomeRevisionIdObj -revision_id $Somerevision_idObj
#>
function Post-CanvasCoursesPagesRevisions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Url
        [Parameter(Mandatory=$true)]
        $Url,

        # The RevisionId
        [Parameter(Mandatory=$true)]
        $RevisionId,

        # The revision to revert to (use the List Revisions API to see available revisions)
        [Parameter(Mandatory=$true)]
        $revision_id
	)

    $uri = "/api/v1/courses/{0}/pages/{1}/revisions/{2}" -f $CourseId, $Url, $RevisionId 

	$Body = @{}

	$Body["revision_id"] = $revision_id

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Get all Peer Reviews 
.DESCRIPTION
   Get a list of all Peer Reviews for this assignment
.EXAMPLE
   PS C:> Get-CanvasCoursesAssignmentsPeerReviews -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -Include $SomeIncludeObj
#>
function Get-CanvasCoursesAssignmentsPeerReviews {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # Associations to include with the peer review.
		#Allowed values: submission_comments, user 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/peer_reviews" -f $CourseId, $AssignmentId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create Peer Review 
.DESCRIPTION
   Create a peer review for the assignment
.EXAMPLE
   PS C:> Post-CanvasCoursesAssignmentsSubmissionsPeerReviews -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -SubmissionId $SomeSubmissionIdObj -user_id $Someuser_idObj
#>
function Post-CanvasCoursesAssignmentsSubmissionsPeerReviews {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The SubmissionId
        [Parameter(Mandatory=$true)]
        $SubmissionId,

        # user_id to assign as reviewer on this assignment
        [Parameter(Mandatory=$true)]
        $user_id
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/submissions/{2}/peer_reviews" -f $CourseId, $AssignmentId, $SubmissionId 

	$Body = @{}

	$Body["user_id"] = $user_id

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Create Peer Review 
.DESCRIPTION
   Delete a peer review for the assignment
.EXAMPLE
   PS C:> Delete-CanvasCoursesAssignmentsSubmissionsPeerReviews -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -SubmissionId $SomeSubmissionIdObj -user_id $Someuser_idObj
#>
function Delete-CanvasCoursesAssignmentsSubmissionsPeerReviews {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The SubmissionId
        [Parameter(Mandatory=$true)]
        $SubmissionId,

        # user_id to delete as reviewer on this assignment
        [Parameter(Mandatory=$true)]
        $user_id
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/submissions/{2}/peer_reviews" -f $CourseId, $AssignmentId, $SubmissionId 

	$Body = @{}

	$Body["user_id"] = $user_id

    return Get-CanvasApiResult $uri -Method DELETE -RequestParameters $Body
}


<#
.Synopsis
   List poll sessions for a poll 
.DESCRIPTION
   Returns the list of PollSessions in this poll.
.EXAMPLE
   PS C:> Get-CanvasPollsPollSessions -PollId $SomePollIdObj
#>
function Get-CanvasPollsPollSessions {
[CmdletBinding()]

	Param
	(
        # The PollId
        [Parameter(Mandatory=$true)]
        $PollId
	)

    $uri = "/api/v1/polls/{0}/poll_sessions" -f $PollId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get the results for a single poll session 
.DESCRIPTION
   Returns the poll session with the given id
.EXAMPLE
   PS C:> Get-CanvasPollsPollSessions -PollId $SomePollIdObj -Id $SomeIdObj
#>
function Get-CanvasPollsPollSessions {
[CmdletBinding()]

	Param
	(
        # The PollId
        [Parameter(Mandatory=$true)]
        $PollId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/polls/{0}/poll_sessions/{1}" -f $PollId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create a single poll session 
.DESCRIPTION
   Create a new poll session for this poll
.EXAMPLE
   PS C:> Post-CanvasPollsPollSessions -PollId $SomePollIdObj -PollSessions[CourseId] $SomePollSessions[CourseId]Obj -PollSessions[CourseSectionId] $SomePollSessions[CourseSectionId]Obj -PollSessions[HasPublicResults] $SomePollSessions[HasPublicResults]Obj
#><#
function Post-CanvasPollsPollSessions {
[CmdletBinding()]

	Param
	(
        # The PollId
        [Parameter(Mandatory=$true)]
        $PollId,

        # The id of the course this session is associated with.
        [Parameter(Mandatory=$true)]
        $PollSessions[CourseId],

        # The id of the course section this session is associated with.
        [Parameter(Mandatory=$false)]
        $PollSessions[CourseSectionId],

        # Whether or not results are viewable by students.
        [Parameter(Mandatory=$false)]
        $PollSessions[HasPublicResults]
	)

    $uri = "/api/v1/polls/{0}/poll_sessions" -f $PollId 

	$Body = @{}

	$Body["poll_sessions[][course_id]"] = $PollSessions[CourseId]

	if ($PollSessions[CourseSectionId]) {$Body["poll_sessions[][course_section_id]"] = $PollSessions[CourseSectionId]}

	if ($PollSessions[HasPublicResults]) {$Body["poll_sessions[][has_public_results]"] = $PollSessions[HasPublicResults]}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Update a single poll session 
.DESCRIPTION
   Update an existing poll session for this poll
.EXAMPLE
   PS C:> Put-CanvasPollsPollSessions -PollId $SomePollIdObj -Id $SomeIdObj -PollSessions[CourseId] $SomePollSessions[CourseId]Obj -PollSessions[CourseSectionId] $SomePollSessions[CourseSectionId]Obj -PollSessions[HasPublicResults] $SomePollSessions[HasPublicResults]Obj
#><#
function Put-CanvasPollsPollSessions {
[CmdletBinding()]

	Param
	(
        # The PollId
        [Parameter(Mandatory=$true)]
        $PollId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The id of the course this session is associated with.
        [Parameter(Mandatory=$false)]
        $PollSessions[CourseId],

        # The id of the course section this session is associated with.
        [Parameter(Mandatory=$false)]
        $PollSessions[CourseSectionId],

        # Whether or not results are viewable by students.
        [Parameter(Mandatory=$false)]
        $PollSessions[HasPublicResults]
	)

    $uri = "/api/v1/polls/{0}/poll_sessions/{1}" -f $PollId, $Id 

	$Body = @{}

	if ($PollSessions[CourseId]) {$Body["poll_sessions[][course_id]"] = $PollSessions[CourseId]}

	if ($PollSessions[CourseSectionId]) {$Body["poll_sessions[][course_section_id]"] = $PollSessions[CourseSectionId]}

	if ($PollSessions[HasPublicResults]) {$Body["poll_sessions[][has_public_results]"] = $PollSessions[HasPublicResults]}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}
#>

<#
.Synopsis
   Delete a poll session 
.DESCRIPTION
   204 No Content response code is returned if the deletion was successful.
.EXAMPLE
   PS C:> Delete-CanvasPollsPollSessions -PollId $SomePollIdObj -Id $SomeIdObj
#>
function Delete-CanvasPollsPollSessions {
[CmdletBinding()]

	Param
	(
        # The PollId
        [Parameter(Mandatory=$true)]
        $PollId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/polls/{0}/poll_sessions/{1}" -f $PollId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Open a poll session 
.DESCRIPTION
   
.EXAMPLE
   PS C:> Get-CanvasPollsPollSessionsOpen -PollId $SomePollIdObj -Id $SomeIdObj
#>
function Get-CanvasPollsPollSessionsOpen {
[CmdletBinding()]

	Param
	(
        # The PollId
        [Parameter(Mandatory=$true)]
        $PollId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/polls/{0}/poll_sessions/{1}/open" -f $PollId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Close an opened poll session 
.DESCRIPTION
   
.EXAMPLE
   PS C:> Get-CanvasPollsPollSessionsClose -PollId $SomePollIdObj -Id $SomeIdObj
#>
function Get-CanvasPollsPollSessionsClose {
[CmdletBinding()]

	Param
	(
        # The PollId
        [Parameter(Mandatory=$true)]
        $PollId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/polls/{0}/poll_sessions/{1}/close" -f $PollId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List opened poll sessions 
.DESCRIPTION
   Lists all opened poll sessions available to the current user.
.EXAMPLE
   PS C:> Get-CanvasPollSessionsOpened
#>
function Get-CanvasPollSessionsOpened {
[CmdletBinding()]

    $uri = "/api/v1/poll_sessions/opened" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List closed poll sessions 
.DESCRIPTION
   Lists all closed poll sessions available to the current user.
.EXAMPLE
   PS C:> Get-CanvasPollSessionsClosed
#>
function Get-CanvasPollSessionsClosed {
[CmdletBinding()]

    $uri = "/api/v1/poll_sessions/closed" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List poll choices in a poll 
.DESCRIPTION
   Returns the list of PollChoices in this poll.
.EXAMPLE
   PS C:> Get-CanvasPollsPollChoices -PollId $SomePollIdObj
#>
function Get-CanvasPollsPollChoices {
[CmdletBinding()]

	Param
	(
        # The PollId
        [Parameter(Mandatory=$true)]
        $PollId
	)

    $uri = "/api/v1/polls/{0}/poll_choices" -f $PollId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get a single poll choice 
.DESCRIPTION
   Returns the poll choice with the given id
.EXAMPLE
   PS C:> Get-CanvasPollsPollChoices -PollId $SomePollIdObj -Id $SomeIdObj
#>
function Get-CanvasPollsPollChoices {
[CmdletBinding()]

	Param
	(
        # The PollId
        [Parameter(Mandatory=$true)]
        $PollId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/polls/{0}/poll_choices/{1}" -f $PollId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create a single poll choice 
.DESCRIPTION
   Create a new poll choice for this poll
.EXAMPLE
   PS C:> Post-CanvasPollsPollChoices -PollId $SomePollIdObj -PollChoices[Text] $SomePollChoices[Text]Obj -PollChoices[IsCorrect] $SomePollChoices[IsCorrect]Obj -PollChoices[Position] $SomePollChoices[Position]Obj
#><#
function Post-CanvasPollsPollChoices {
[CmdletBinding()]

	Param
	(
        # The PollId
        [Parameter(Mandatory=$true)]
        $PollId,

        # The descriptive text of the poll choice.
        [Parameter(Mandatory=$true)]
        $PollChoices[Text],

        # Whether this poll choice is considered correct or not. Defaults to false.
        [Parameter(Mandatory=$false)]
        $PollChoices[IsCorrect],

        # The order this poll choice should be returned in the context it's sibling poll choices.
        [Parameter(Mandatory=$false)]
        $PollChoices[Position]
	)

    $uri = "/api/v1/polls/{0}/poll_choices" -f $PollId 

	$Body = @{}

	$Body["poll_choices[][text]"] = $PollChoices[Text]

	if ($PollChoices[IsCorrect]) {$Body["poll_choices[][is_correct]"] = $PollChoices[IsCorrect]}

	if ($PollChoices[Position]) {$Body["poll_choices[][position]"] = $PollChoices[Position]}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Update a single poll choice 
.DESCRIPTION
   Update an existing poll choice for this poll
.EXAMPLE
   PS C:> Put-CanvasPollsPollChoices -PollId $SomePollIdObj -Id $SomeIdObj -PollChoices[Text] $SomePollChoices[Text]Obj -PollChoices[IsCorrect] $SomePollChoices[IsCorrect]Obj -PollChoices[Position] $SomePollChoices[Position]Obj
#><#
function Put-CanvasPollsPollChoices {
[CmdletBinding()]

	Param
	(
        # The PollId
        [Parameter(Mandatory=$true)]
        $PollId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The descriptive text of the poll choice.
        [Parameter(Mandatory=$true)]
        $PollChoices[Text],

        # Whether this poll choice is considered correct or not. Defaults to false.
        [Parameter(Mandatory=$false)]
        $PollChoices[IsCorrect],

        # The order this poll choice should be returned in the context it's sibling poll choices.
        [Parameter(Mandatory=$false)]
        $PollChoices[Position]
	)

    $uri = "/api/v1/polls/{0}/poll_choices/{1}" -f $PollId, $Id 

	$Body = @{}

	$Body["poll_choices[][text]"] = $PollChoices[Text]

	if ($PollChoices[IsCorrect]) {$Body["poll_choices[][is_correct]"] = $PollChoices[IsCorrect]}

	if ($PollChoices[Position]) {$Body["poll_choices[][position]"] = $PollChoices[Position]}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}
#>

<#
.Synopsis
   Delete a poll choice 
.DESCRIPTION
   204 No Content response code is returned if the deletion was successful.
.EXAMPLE
   PS C:> Delete-CanvasPollsPollChoices -PollId $SomePollIdObj -Id $SomeIdObj
#>
function Delete-CanvasPollsPollChoices {
[CmdletBinding()]

	Param
	(
        # The PollId
        [Parameter(Mandatory=$true)]
        $PollId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/polls/{0}/poll_choices/{1}" -f $PollId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Get a single poll submission 
.DESCRIPTION
   Returns the poll submission with the given id
.EXAMPLE
   PS C:> Get-CanvasPollsPollSessionsPollSubmissions -PollId $SomePollIdObj -PollSessionId $SomePollSessionIdObj -Id $SomeIdObj
#>
function Get-CanvasPollsPollSessionsPollSubmissions {
[CmdletBinding()]

	Param
	(
        # The PollId
        [Parameter(Mandatory=$true)]
        $PollId,

        # The PollSessionId
        [Parameter(Mandatory=$true)]
        $PollSessionId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/polls/{0}/poll_sessions/{1}/poll_submissions/{2}" -f $PollId, $PollSessionId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create a single poll submission 
.DESCRIPTION
   Create a new poll submission for this poll session
.EXAMPLE
   PS C:> Post-CanvasPollsPollSessionsPollSubmissions -PollId $SomePollIdObj -PollSessionId $SomePollSessionIdObj -PollSubmissions[PollChoiceId] $SomePollSubmissions[PollChoiceId]Obj
#><#
function Post-CanvasPollsPollSessionsPollSubmissions {
[CmdletBinding()]

	Param
	(
        # The PollId
        [Parameter(Mandatory=$true)]
        $PollId,

        # The PollSessionId
        [Parameter(Mandatory=$true)]
        $PollSessionId,

        # The chosen poll choice for this submission.
        [Parameter(Mandatory=$true)]
        $PollSubmissions[PollChoiceId]
	)

    $uri = "/api/v1/polls/{0}/poll_sessions/{1}/poll_submissions" -f $PollId, $PollSessionId 

	$Body = @{}

	$Body["poll_submissions[][poll_choice_id]"] = $PollSubmissions[PollChoiceId]

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   List polls 
.DESCRIPTION
   Returns the list of polls for the current user.
.EXAMPLE
   PS C:> Get-CanvasPolls
#>
function Get-CanvasPolls {
[CmdletBinding()]

    $uri = "/api/v1/polls" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get a single poll 
.DESCRIPTION
   Returns the poll with the given id
.EXAMPLE
   PS C:> Get-CanvasPolls -Id $SomeIdObj
#>
function Get-CanvasPolls {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/polls/{0}" -f $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create a single poll 
.DESCRIPTION
   Create a new poll for the current user
.EXAMPLE
   PS C:> Post-CanvasPolls -Polls[Question] $SomePolls[Question]Obj -Polls[Description] $SomePolls[Description]Obj
#><#
function Post-CanvasPolls {
[CmdletBinding()]

	Param
	(
        # The title of the poll.
        [Parameter(Mandatory=$true)]
        $Polls[Question],

        # A brief description or instructions for the poll.
        [Parameter(Mandatory=$false)]
        $Polls[Description]
	)

    $uri = "/api/v1/polls" 

	$Body = @{}

	$Body["polls[][question]"] = $Polls[Question]

	if ($Polls[Description]) {$Body["polls[][description]"] = $Polls[Description]}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Update a single poll 
.DESCRIPTION
   Update an existing poll belonging to the current user
.EXAMPLE
   PS C:> Put-CanvasPolls -Id $SomeIdObj -Polls[Question] $SomePolls[Question]Obj -Polls[Description] $SomePolls[Description]Obj
#><#
function Put-CanvasPolls {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The title of the poll.
        [Parameter(Mandatory=$true)]
        $Polls[Question],

        # A brief description or instructions for the poll.
        [Parameter(Mandatory=$false)]
        $Polls[Description]
	)

    $uri = "/api/v1/polls/{0}" -f $Id 

	$Body = @{}

	$Body["polls[][question]"] = $Polls[Question]

	if ($Polls[Description]) {$Body["polls[][description]"] = $Polls[Description]}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}
#>

<#
.Synopsis
   Delete a poll 
.DESCRIPTION
   204 No Content response code is returned if the deletion was successful.
.EXAMPLE
   PS C:> Delete-CanvasPolls -Id $SomeIdObj
#>
function Delete-CanvasPolls {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/polls/{0}" -f $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Query progress 
.DESCRIPTION
   Return completion and status information about an asynchronous job
.EXAMPLE
   PS C:> Get-CanvasProgress -Id $SomeIdObj
#>
function Get-CanvasProgress {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/progress/{0}" -f $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Retrieve assignment-overridden dates for quizzes 
.DESCRIPTION
   Retrieve the actual due-at, unlock-at, and available-at dates for quizzes based on the assignment overrides active for the current API user.
.EXAMPLE
   PS C:> Get-CanvasCoursesQuizzesAssignmentOverrides -CourseId $SomeCourseIdObj -QuizAssignmentOverrides[0][QuizIds] $SomeQuizAssignmentOverrides[0][QuizIds]Obj
#><#
function Get-CanvasCoursesQuizzesAssignmentOverrides {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # An array of quiz IDs. If omitted, overrides for all quizzes available to the operating user will be returned.
        [Parameter(Mandatory=$false)]
        $QuizAssignmentOverrides[0][QuizIds]
	)

    $uri = "/api/v1/courses/{0}/quizzes/assignment_overrides" -f $CourseId 

	$Body = @{}

	if ($QuizAssignmentOverrides[0][QuizIds]) {$Body["quiz_assignment_overrides[0][quiz_ids][]"] = $QuizAssignmentOverrides[0][QuizIds]}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}
#>

<#
.Synopsis
   Set extensions for student quiz submissions 
.DESCRIPTION
   Responses
.EXAMPLE
   PS C:> Post-CanvasCoursesQuizzesExtensions -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -user_id $Someuser_idObj -extra_attempts $Someextra_attemptsObj -extra_time $Someextra_timeObj -manually_unlocked $Somemanually_unlockedObj -extend_from_now $Someextend_from_nowObj -extend_from_end_at $Someextend_from_end_atObj
#>
function Post-CanvasCoursesQuizzesExtensions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The ID of the user we want to add quiz extensions for.
        [Parameter(Mandatory=$true)]
        $user_id,

        # Number of times the student is allowed to re-take the quiz over the multiple-attempt limit. This is limited to 1000 attempts or less.
        [Parameter(Mandatory=$false)]
        $extra_attempts,

        # The number of extra minutes to allow for all attempts. This will add to the existing time limit on the submission. This is limited to 10080 minutes (1 week)
        [Parameter(Mandatory=$false)]
        $extra_time,

        # Allow the student to take the quiz even if it's locked for everyone else.
        [Parameter(Mandatory=$false)]
        $manually_unlocked,

        # The number of minutes to extend the quiz from the current time. This is mutually exclusive to extend_from_end_at. This is limited to 1440 minutes (24 hours)
        [Parameter(Mandatory=$false)]
        $extend_from_now,

        # The number of minutes to extend the quiz beyond the quiz's current ending time. This is mutually exclusive to extend_from_now. This is limited to 1440 minutes (24 hours)
        [Parameter(Mandatory=$false)]
        $extend_from_end_at
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/extensions" -f $CourseId, $QuizId 

	$Body = @{}

	$Body["user_id"] = $user_id

	if ($extra_attempts) {$Body["extra_attempts"] = $extra_attempts}

	if ($extra_time) {$Body["extra_time"] = $extra_time}

	if ($manually_unlocked) {$Body["manually_unlocked"] = $manually_unlocked}

	if ($extend_from_now) {$Body["extend_from_now"] = $extend_from_now}

	if ($extend_from_end_at) {$Body["extend_from_end_at"] = $extend_from_end_at}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Get available quiz IP filters. 
.DESCRIPTION
   Get a list of available IP filters for this Quiz. 200 OK response code is returned if the request was successful.
.EXAMPLE
   PS C:> Get-CanvasCoursesQuizzesIpFilters -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj
#>
function Get-CanvasCoursesQuizzesIpFilters {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/ip_filters" -f $CourseId, $QuizId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get a single quiz group 
.DESCRIPTION
   Returns details of the quiz group with the given id.
.EXAMPLE
   PS C:> Get-CanvasCoursesQuizzesGroups -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Id $SomeIdObj
#>
function Get-CanvasCoursesQuizzesGroups {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/groups/{2}" -f $CourseId, $QuizId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create a question group 
.DESCRIPTION
   Create a new question group for this quiz 201 Created response code is returned if the creation was successful.
.EXAMPLE
   PS C:> Post-CanvasCoursesQuizzesGroups -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -QuizGroups[Name] $SomeQuizGroups[Name]Obj -QuizGroups[PickCount] $SomeQuizGroups[PickCount]Obj -QuizGroups[QuestionPoints] $SomeQuizGroups[QuestionPoints]Obj -QuizGroups[AssessmentQuestionBankId] $SomeQuizGroups[AssessmentQuestionBankId]Obj
#><#
function Post-CanvasCoursesQuizzesGroups {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The name of the question group.
        [Parameter(Mandatory=$false)]
        $QuizGroups[Name],

        # The number of questions to randomly select for this group.
        [Parameter(Mandatory=$false)]
        $QuizGroups[PickCount],

        # The number of points to assign to each question in the group.
        [Parameter(Mandatory=$false)]
        $QuizGroups[QuestionPoints],

        # The id of the assessment question bank to pull questions from.
        [Parameter(Mandatory=$false)]
        $QuizGroups[AssessmentQuestionBankId]
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/groups" -f $CourseId, $QuizId 

	$Body = @{}

	if ($QuizGroups[Name]) {$Body["quiz_groups[][name]"] = $QuizGroups[Name]}

	if ($QuizGroups[PickCount]) {$Body["quiz_groups[][pick_count]"] = $QuizGroups[PickCount]}

	if ($QuizGroups[QuestionPoints]) {$Body["quiz_groups[][question_points]"] = $QuizGroups[QuestionPoints]}

	if ($QuizGroups[AssessmentQuestionBankId]) {$Body["quiz_groups[][assessment_question_bank_id]"] = $QuizGroups[AssessmentQuestionBankId]}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Update a question group 
.DESCRIPTION
   Update a question group
.EXAMPLE
   PS C:> Put-CanvasCoursesQuizzesGroups -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Id $SomeIdObj -QuizGroups[Name] $SomeQuizGroups[Name]Obj -QuizGroups[PickCount] $SomeQuizGroups[PickCount]Obj -QuizGroups[QuestionPoints] $SomeQuizGroups[QuestionPoints]Obj
#><#
function Put-CanvasCoursesQuizzesGroups {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The name of the question group.
        [Parameter(Mandatory=$false)]
        $QuizGroups[Name],

        # The number of questions to randomly select for this group.
        [Parameter(Mandatory=$false)]
        $QuizGroups[PickCount],

        # The number of points to assign to each question in the group.
        [Parameter(Mandatory=$false)]
        $QuizGroups[QuestionPoints]
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/groups/{2}" -f $CourseId, $QuizId, $Id 

	$Body = @{}

	if ($QuizGroups[Name]) {$Body["quiz_groups[][name]"] = $QuizGroups[Name]}

	if ($QuizGroups[PickCount]) {$Body["quiz_groups[][pick_count]"] = $QuizGroups[PickCount]}

	if ($QuizGroups[QuestionPoints]) {$Body["quiz_groups[][question_points]"] = $QuizGroups[QuestionPoints]}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}
#>

<#
.Synopsis
   Delete a question group 
.DESCRIPTION
   Delete a question group <b>204 No Content<b> response code is returned if the deletion was successful.
.EXAMPLE
   PS C:> Delete-CanvasCoursesQuizzesGroups -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Id $SomeIdObj
#>
function Delete-CanvasCoursesQuizzesGroups {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/groups/{2}" -f $CourseId, $QuizId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Reorder question groups 
.DESCRIPTION
   Change the order of the quiz questions within the group <b>204 No Content<b> response code is returned if the reorder was successful.
.EXAMPLE
   PS C:> Post-CanvasCoursesQuizzesGroupsReorder -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Id $SomeIdObj -Order[Id] $SomeOrder[Id]Obj -Order[Type] $SomeOrder[Type]Obj
#><#
function Post-CanvasCoursesQuizzesGroupsReorder {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The associated item's unique identifier
        [Parameter(Mandatory=$true)]
        $Order[Id],

        # The type of item is always 'question' for a group
		#Allowed values: question 
        [Parameter(Mandatory=$false)]
        $Order[Type]
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/groups/{2}/reorder" -f $CourseId, $QuizId, $Id 

	$Body = @{}

	$Body["order[][id]"] = $Order[Id]

	if ($Order[Type]) {$Body["order[][type]"] = $Order[Type]}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   List questions in a quiz or a submission 
.DESCRIPTION
   Returns the list of QuizQuestions in this quiz.
.EXAMPLE
   PS C:> Get-CanvasCoursesQuizzesQuestions -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -quiz_submission_id $Somequiz_submission_idObj -quiz_submission_attempt $Somequiz_submission_attemptObj
#>
function Get-CanvasCoursesQuizzesQuestions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # If specified, the endpoint will return the questions that were presented for that submission. This is useful if the quiz has been modified after the submission was created and the latest quiz version's set of questions does not match the submission's. NOTE: you must specify quiz_submission_attempt as well if you specify this parameter.
        [Parameter(Mandatory=$false)]
        $quiz_submission_id,

        # The attempt of the submission you want the questions for.
        [Parameter(Mandatory=$false)]
        $quiz_submission_attempt
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/questions" -f $CourseId, $QuizId 

	$Body = @{}

	if ($quiz_submission_id) {$Body["quiz_submission_id"] = $quiz_submission_id}

	if ($quiz_submission_attempt) {$Body["quiz_submission_attempt"] = $quiz_submission_attempt}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get a single quiz question 
.DESCRIPTION
   Returns the quiz question with the given id
.EXAMPLE
   PS C:> Get-CanvasCoursesQuizzesQuestions -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Id $SomeIdObj -id $SomeidObj
#><#
function Get-CanvasCoursesQuizzesQuestions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The quiz question unique identifier.
        [Parameter(Mandatory=$true)]
        $id
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/questions/{2}" -f $CourseId, $QuizId, $Id 

	$Body = @{}

	$Body["id"] = $id

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}
#>

<#
.Synopsis
   Create a single quiz question 
.DESCRIPTION
   Create a new quiz question for this quiz
.EXAMPLE
   PS C:> Post-CanvasCoursesQuizzesQuestions -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -QuestionName $SomeQuestionNameObj -QuestionText $SomeQuestionTextObj -QuizGroupId $SomeQuizGroupIdObj -QuestionType $SomeQuestionTypeObj -Position $SomePositionObj -PointsPossible $SomePointsPossibleObj -CorrectComments $SomeCorrectCommentsObj -IncorrectComments $SomeIncorrectCommentsObj -NeutralComments $SomeNeutralCommentsObj -TextAfterAnswers $SomeTextAfterAnswersObj -Answers $SomeAnswersObj
#>
function Post-CanvasCoursesQuizzesQuestions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The name of the question.
        [Parameter(Mandatory=$false)]
        $QuestionName,

        # The text of the question.
        [Parameter(Mandatory=$false)]
        $QuestionText,

        # The id of the quiz group to assign the question to.
        [Parameter(Mandatory=$false)]
        $QuizGroupId,

        # The type of question. Multiple optional fields depend upon the type of question to be used.
		#Allowed values: calculated_question, essay_question, file_upload_question, fill_in_multiple_blanks_question, matching_question, multiple_answers_question, multiple_choice_question, multiple_dropdowns_question, numerical_question, short_answer_question, text_only_question, true_false_question 
        [Parameter(Mandatory=$false)]
        $QuestionType,

        # The order in which the question will be displayed in the quiz in relation to other questions.
        [Parameter(Mandatory=$false)]
        $Position,

        # The maximum amount of points received for answering this question correctly.
        [Parameter(Mandatory=$false)]
        $PointsPossible,

        # The comment to display if the student answers the question correctly.
        [Parameter(Mandatory=$false)]
        $CorrectComments,

        # The comment to display if the student answers incorrectly.
        [Parameter(Mandatory=$false)]
        $IncorrectComments,

        # The comment to display regardless of how the student answered.
        [Parameter(Mandatory=$false)]
        $NeutralComments,

        # no description
        [Parameter(Mandatory=$false)]
        $TextAfterAnswers,

        # no description
        [Parameter(Mandatory=$false)]
        $Answers
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/questions" -f $CourseId, $QuizId 

	$Body = @{}

	if ($QuestionName) {$Body["question[question_name]"] = $QuestionName}

	if ($QuestionText) {$Body["question[question_text]"] = $QuestionText}

	if ($QuizGroupId) {$Body["question[quiz_group_id]"] = $QuizGroupId}

	if ($QuestionType) {$Body["question[question_type]"] = $QuestionType}

	if ($Position) {$Body["question[position]"] = $Position}

	if ($PointsPossible) {$Body["question[points_possible]"] = $PointsPossible}

	if ($CorrectComments) {$Body["question[correct_comments]"] = $CorrectComments}

	if ($IncorrectComments) {$Body["question[incorrect_comments]"] = $IncorrectComments}

	if ($NeutralComments) {$Body["question[neutral_comments]"] = $NeutralComments}

	if ($TextAfterAnswers) {$Body["question[text_after_answers]"] = $TextAfterAnswers}

	if ($Answers) {$Body["question[answers]"] = $Answers}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Update an existing quiz question 
.DESCRIPTION
   Updates an existing quiz question for this quiz
.EXAMPLE
   PS C:> Put-CanvasCoursesQuizzesQuestions -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Id $SomeIdObj -quiz_id $Somequiz_idObj -id $SomeidObj -QuestionName $SomeQuestionNameObj -QuestionText $SomeQuestionTextObj -QuizGroupId $SomeQuizGroupIdObj -QuestionType $SomeQuestionTypeObj -Position $SomePositionObj -PointsPossible $SomePointsPossibleObj -CorrectComments $SomeCorrectCommentsObj -IncorrectComments $SomeIncorrectCommentsObj -NeutralComments $SomeNeutralCommentsObj -TextAfterAnswers $SomeTextAfterAnswersObj -Answers $SomeAnswersObj
#><#
function Put-CanvasCoursesQuizzesQuestions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The associated quiz's unique identifier.
        [Parameter(Mandatory=$true)]
        $quiz_id,

        # The quiz question's unique identifier.
        [Parameter(Mandatory=$true)]
        $id,

        # The name of the question.
        [Parameter(Mandatory=$false)]
        $QuestionName,

        # The text of the question.
        [Parameter(Mandatory=$false)]
        $QuestionText,

        # The id of the quiz group to assign the question to.
        [Parameter(Mandatory=$false)]
        $QuizGroupId,

        # The type of question. Multiple optional fields depend upon the type of question to be used.
		#Allowed values: calculated_question, essay_question, file_upload_question, fill_in_multiple_blanks_question, matching_question, multiple_answers_question, multiple_choice_question, multiple_dropdowns_question, numerical_question, short_answer_question, text_only_question, true_false_question 
        [Parameter(Mandatory=$false)]
        $QuestionType,

        # The order in which the question will be displayed in the quiz in relation to other questions.
        [Parameter(Mandatory=$false)]
        $Position,

        # The maximum amount of points received for answering this question correctly.
        [Parameter(Mandatory=$false)]
        $PointsPossible,

        # The comment to display if the student answers the question correctly.
        [Parameter(Mandatory=$false)]
        $CorrectComments,

        # The comment to display if the student answers incorrectly.
        [Parameter(Mandatory=$false)]
        $IncorrectComments,

        # The comment to display regardless of how the student answered.
        [Parameter(Mandatory=$false)]
        $NeutralComments,

        # no description
        [Parameter(Mandatory=$false)]
        $TextAfterAnswers,

        # no description
        [Parameter(Mandatory=$false)]
        $Answers
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/questions/{2}" -f $CourseId, $QuizId, $Id 

	$Body = @{}

	$Body["quiz_id"] = $quiz_id

	$Body["id"] = $id

	if ($QuestionName) {$Body["question[question_name]"] = $QuestionName}

	if ($QuestionText) {$Body["question[question_text]"] = $QuestionText}

	if ($QuizGroupId) {$Body["question[quiz_group_id]"] = $QuizGroupId}

	if ($QuestionType) {$Body["question[question_type]"] = $QuestionType}

	if ($Position) {$Body["question[position]"] = $Position}

	if ($PointsPossible) {$Body["question[points_possible]"] = $PointsPossible}

	if ($CorrectComments) {$Body["question[correct_comments]"] = $CorrectComments}

	if ($IncorrectComments) {$Body["question[incorrect_comments]"] = $IncorrectComments}

	if ($NeutralComments) {$Body["question[neutral_comments]"] = $NeutralComments}

	if ($TextAfterAnswers) {$Body["question[text_after_answers]"] = $TextAfterAnswers}

	if ($Answers) {$Body["question[answers]"] = $Answers}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}
#>

<#
.Synopsis
   Delete a quiz question 
.DESCRIPTION
   204 No Content response code is returned if the deletion was successful.
.EXAMPLE
   PS C:> Delete-CanvasCoursesQuizzesQuestions -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Id $SomeIdObj -quiz_id $Somequiz_idObj -id $SomeidObj
#><#
function Delete-CanvasCoursesQuizzesQuestions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The associated quiz's unique identifier
        [Parameter(Mandatory=$true)]
        $quiz_id,

        # The quiz question's unique identifier
        [Parameter(Mandatory=$true)]
        $id
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/questions/{2}" -f $CourseId, $QuizId, $Id 

	$Body = @{}

	$Body["quiz_id"] = $quiz_id

	$Body["id"] = $id

    return Get-CanvasApiResult $uri -Method DELETE -RequestParameters $Body
}
#>

<#
.Synopsis
   Retrieve all quiz reports 
.DESCRIPTION
   Returns a list of all available reports.
.EXAMPLE
   PS C:> Get-CanvasCoursesQuizzesReports -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -includes_all_versions $Someincludes_all_versionsObj
#>
function Get-CanvasCoursesQuizzesReports {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # Whether to retrieve reports that consider all the submissions or only the most recent. Defaults to false, ignored for item_analysis reports.
        [Parameter(Mandatory=$false)]
        $includes_all_versions
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/reports" -f $CourseId, $QuizId 

	$Body = @{}

	if ($includes_all_versions) {$Body["includes_all_versions"] = $includes_all_versions}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create a quiz report 
.DESCRIPTION
   Create and return a new report for this quiz. If a previously generated report matches the arguments and is still current (i.e. there have been no new submissions), it will be returned. Responses
.EXAMPLE
   PS C:> Post-CanvasCoursesQuizzesReports -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -ReportType $SomeReportTypeObj -IncludesAllVersions $SomeIncludesAllVersionsObj -include $SomeincludeObj
#>
function Post-CanvasCoursesQuizzesReports {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The type of report to be generated.
		#Allowed values: student_analysis, item_analysis 
        [Parameter(Mandatory=$true)]
        $ReportType,

        # Whether the report should consider all submissions or only the most recent. Defaults to false, ignored for item_analysis.
        [Parameter(Mandatory=$false)]
        $IncludesAllVersions,

        # Whether the output should include documents for the file and/or progress objects associated with this report. (Note: JSON-API only)
		#Allowed values: file, progress 
        [Parameter(Mandatory=$false)]
        $include
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/reports" -f $CourseId, $QuizId 

	$Body = @{}

	$Body["quiz_report[report_type]"] = $ReportType

	if ($IncludesAllVersions) {$Body["quiz_report[includes_all_versions]"] = $IncludesAllVersions}

	if ($include) {$Body["include"] = $include}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Get a quiz report 
.DESCRIPTION
   Returns the data for a single quiz report.
.EXAMPLE
   PS C:> Get-CanvasCoursesQuizzesReports -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Id $SomeIdObj -include $SomeincludeObj
#>
function Get-CanvasCoursesQuizzesReports {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Whether the output should include documents for the file and/or progress objects associated with this report. (Note: JSON-API only)
		#Allowed values: file, progress 
        [Parameter(Mandatory=$false)]
        $include
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/reports/{2}" -f $CourseId, $QuizId, $Id 

	$Body = @{}

	if ($include) {$Body["include"] = $include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Abort the generation of a report, or remove a previously generated one 
.DESCRIPTION
   This API allows you to cancel a previous request you issued for a report to be generated. Or in the case of an already generated report, you'd like to remove it, perhaps to generate it another time with an updated version that provides new features. You must check the report's generation status before attempting to use this interface. See the âworkflow_stateâ property of the QuizReport's Progress object for more information. Only when the progress reports itself in a âqueuedâ state can the generation be aborted. Responses
.EXAMPLE
   PS C:> Delete-CanvasCoursesQuizzesReports -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Id $SomeIdObj
#>
function Delete-CanvasCoursesQuizzesReports {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/reports/{2}" -f $CourseId, $QuizId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Fetching the latest quiz statistics 
.DESCRIPTION
   This endpoint provides statistics for all quiz versions, or for a specific quiz version, in which case the output is guaranteed to represent the latest and most current version of the quiz. 200 OK response code is returned if the request was successful.
.EXAMPLE
   PS C:> Get-CanvasCoursesQuizzesStatistics -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -all_versions $Someall_versionsObj
#>
function Get-CanvasCoursesQuizzesStatistics {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # Whether the statistics report should include all submissions attempts.
        [Parameter(Mandatory=$false)]
        $all_versions
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/statistics" -f $CourseId, $QuizId 

	$Body = @{}

	if ($all_versions) {$Body["all_versions"] = $all_versions}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Submit captured events 
.DESCRIPTION
   Store a set of events which were captured during a quiz taking session. On success, the response will be 204 No Content with an empty body.
.EXAMPLE
   PS C:> Post-CanvasCoursesQuizzesSubmissionsEvents -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Id $SomeIdObj -QuizSubmissionEvents $SomeQuizSubmissionEventsObj
#>
function Post-CanvasCoursesQuizzesSubmissionsEvents {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The submission events to be recorded
        [Parameter(Mandatory=$true)]
        $QuizSubmissionEvents
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/submissions/{2}/events" -f $CourseId, $QuizId, $Id 

	$Body = @{}

	$Body["quiz_submission_events[]"] = $QuizSubmissionEvents

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Retrieve captured events 
.DESCRIPTION
   Retrieve the set of events captured during a specific submission attempt.
.EXAMPLE
   PS C:> Get-CanvasCoursesQuizzesSubmissionsEvents -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Id $SomeIdObj -attempt $SomeattemptObj
#>
function Get-CanvasCoursesQuizzesSubmissionsEvents {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The specific submission attempt to look up the events for. If unspecified, the latest attempt will be used.
        [Parameter(Mandatory=$false)]
        $attempt
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/submissions/{2}/events" -f $CourseId, $QuizId, $Id 

	$Body = @{}

	if ($attempt) {$Body["attempt"] = $attempt}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Upload a file 
.DESCRIPTION
   Associate a new quiz submission file This API endpoint is the first step in uploading a quiz submission file. See the File Upload Documentation for details on the file upload workflow as these parameters are interpreted as per the documentation there.
.EXAMPLE
   PS C:> Post-CanvasCoursesQuizzesSubmissionsSelfFiles -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -name $SomenameObj -on_duplicate $Someon_duplicateObj
#>
function Post-CanvasCoursesQuizzesSubmissionsSelfFiles {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The name of the quiz submission file
        [Parameter(Mandatory=$false)]
        $name,

        # How to handle duplicate names
        [Parameter(Mandatory=$false)]
        $on_duplicate
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/submissions/self/files" -f $CourseId, $QuizId 

	$Body = @{}

	if ($name) {$Body["name"] = $name}

	if ($on_duplicate) {$Body["on_duplicate"] = $on_duplicate}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Get all quiz submission questions. 
.DESCRIPTION
   Get a list of all the question records for this quiz submission. 200 OK response code is returned if the request was successful.
.EXAMPLE
   PS C:> Get-CanvasQuizSubmissionsQuestions -QuizSubmissionId $SomeQuizSubmissionIdObj -Include $SomeIncludeObj
#>
function Get-CanvasQuizSubmissionsQuestions {
[CmdletBinding()]

	Param
	(
        # The QuizSubmissionId
        [Parameter(Mandatory=$true)]
        $QuizSubmissionId,

        # Associations to include with the quiz submission question.
		#Allowed values: quiz_question 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/quiz_submissions/{0}/questions" -f $QuizSubmissionId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Answering questions 
.DESCRIPTION
   Provide or update an answer to one or more QuizQuestions.
.EXAMPLE
   PS C:> Post-CanvasQuizSubmissionsQuestions -QuizSubmissionId $SomeQuizSubmissionIdObj -attempt $SomeattemptObj -validation_token $Somevalidation_tokenObj -access_code $Someaccess_codeObj -QuizQuestions $SomeQuizQuestionsObj
#>
function Post-CanvasQuizSubmissionsQuestions {
[CmdletBinding()]

	Param
	(
        # The QuizSubmissionId
        [Parameter(Mandatory=$true)]
        $QuizSubmissionId,

        # The attempt number of the quiz submission being taken. Note that this must be the latest attempt index, as questions for earlier attempts can not be modified.
        [Parameter(Mandatory=$true)]
        $attempt,

        # The unique validation token you received when the Quiz Submission was created.
        [Parameter(Mandatory=$true)]
        $validation_token,

        # Access code for the Quiz, if any.
        [Parameter(Mandatory=$false)]
        $access_code,

        # Set of question IDs and the answer value.
		#See Appendix: Question Answer Formats for the accepted answer formats for each question type.
        [Parameter(Mandatory=$false)]
        $QuizQuestions
	)

    $uri = "/api/v1/quiz_submissions/{0}/questions" -f $QuizSubmissionId 

	$Body = @{}

	$Body["attempt"] = $attempt

	$Body["validation_token"] = $validation_token

	if ($access_code) {$Body["access_code"] = $access_code}

	if ($QuizQuestions) {$Body["quiz_questions[]"] = $QuizQuestions}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Flagging a question. 
.DESCRIPTION
   Set a flag on a quiz question to indicate that you want to return to it later.
.EXAMPLE
   PS C:> Put-CanvasQuizSubmissionsQuestionsFlag -QuizSubmissionId $SomeQuizSubmissionIdObj -Id $SomeIdObj -attempt $SomeattemptObj -validation_token $Somevalidation_tokenObj -access_code $Someaccess_codeObj
#>
function Put-CanvasQuizSubmissionsQuestionsFlag {
[CmdletBinding()]

	Param
	(
        # The QuizSubmissionId
        [Parameter(Mandatory=$true)]
        $QuizSubmissionId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The attempt number of the quiz submission being taken. Note that this must be the latest attempt index, as questions for earlier attempts can not be modified.
        [Parameter(Mandatory=$true)]
        $attempt,

        # The unique validation token you received when the Quiz Submission was created.
        [Parameter(Mandatory=$true)]
        $validation_token,

        # Access code for the Quiz, if any.
        [Parameter(Mandatory=$false)]
        $access_code
	)

    $uri = "/api/v1/quiz_submissions/{0}/questions/{1}/flag" -f $QuizSubmissionId, $Id 

	$Body = @{}

	$Body["attempt"] = $attempt

	$Body["validation_token"] = $validation_token

	if ($access_code) {$Body["access_code"] = $access_code}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Unflagging a question. 
.DESCRIPTION
   Remove the flag that you previously set on a quiz question after you've returned to it.
.EXAMPLE
   PS C:> Put-CanvasQuizSubmissionsQuestionsUnflag -QuizSubmissionId $SomeQuizSubmissionIdObj -Id $SomeIdObj -attempt $SomeattemptObj -validation_token $Somevalidation_tokenObj -access_code $Someaccess_codeObj
#>
function Put-CanvasQuizSubmissionsQuestionsUnflag {
[CmdletBinding()]

	Param
	(
        # The QuizSubmissionId
        [Parameter(Mandatory=$true)]
        $QuizSubmissionId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The attempt number of the quiz submission being taken. Note that this must be the latest attempt index, as questions for earlier attempts can not be modified.
        [Parameter(Mandatory=$true)]
        $attempt,

        # The unique validation token you received when the Quiz Submission was created.
        [Parameter(Mandatory=$true)]
        $validation_token,

        # Access code for the Quiz, if any.
        [Parameter(Mandatory=$false)]
        $access_code
	)

    $uri = "/api/v1/quiz_submissions/{0}/questions/{1}/unflag" -f $QuizSubmissionId, $Id 

	$Body = @{}

	$Body["attempt"] = $attempt

	$Body["validation_token"] = $validation_token

	if ($access_code) {$Body["access_code"] = $access_code}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Send a message to unsubmitted or submitted users for the quiz 
.DESCRIPTION
   { }
.EXAMPLE
   PS C:> Post-CanvasCoursesQuizzesSubmissionUsersMessage -CourseId $SomeCourseIdObj -Id $SomeIdObj -conversations $SomeconversationsObj
#>
function Post-CanvasCoursesQuizzesSubmissionUsersMessage {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Body and recipients to send the message to.
        [Parameter(Mandatory=$false)]
        $conversations
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/submission_users/message" -f $CourseId, $Id 

	$Body = @{}

	if ($conversations) {$Body["conversations"] = $conversations}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Get all quiz submissions. 
.DESCRIPTION
   Get a list of all submissions for this quiz. Users who can view or manage grades for a course will have submissions from multiple users returned. A user who can only submit will have only their own submissions returned. When a user has an in-progress submission, only that submission is returned. When there isn't an in-progress quiz_submission, all completed submissions, including previous attempts, are returned. 200 OK response code is returned if the request was successful.
.EXAMPLE
   PS C:> Get-CanvasCoursesQuizzesSubmissions -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Include $SomeIncludeObj
#>
function Get-CanvasCoursesQuizzesSubmissions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # Associations to include with the quiz submission.
		#Allowed values: submission, quiz, user 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/submissions" -f $CourseId, $QuizId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get the quiz submission. 
.DESCRIPTION
   Get the submission for this quiz for the current user. 200 OK response code is returned if the request was successful.
.EXAMPLE
   PS C:> Get-CanvasCoursesQuizzesSubmission -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Include $SomeIncludeObj
#>
function Get-CanvasCoursesQuizzesSubmission {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # Associations to include with the quiz submission.
		#Allowed values: submission, quiz, user 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/submission" -f $CourseId, $QuizId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get a single quiz submission. 
.DESCRIPTION
   Get a single quiz submission. 200 OK response code is returned if the request was successful.
.EXAMPLE
   PS C:> Get-CanvasCoursesQuizzesSubmissions -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Id $SomeIdObj -Include $SomeIncludeObj
#>
function Get-CanvasCoursesQuizzesSubmissions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # Associations to include with the quiz submission.
		#Allowed values: submission, quiz, user 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/submissions/{2}" -f $CourseId, $QuizId, $Id 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create the quiz submission (start a quiz-taking session) 
.DESCRIPTION
   Start taking a Quiz by creating a QuizSubmission which you can use to answer questions and submit your answers. Responses
.EXAMPLE
   PS C:> Post-CanvasCoursesQuizzesSubmissions -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -access_code $Someaccess_codeObj -preview $SomepreviewObj
#>
function Post-CanvasCoursesQuizzesSubmissions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # Access code for the Quiz, if any.
        [Parameter(Mandatory=$false)]
        $access_code,

        # Whether this should be a preview QuizSubmission and not count towards the user's course record. Teachers only.
        [Parameter(Mandatory=$false)]
        $preview
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/submissions" -f $CourseId, $QuizId 

	$Body = @{}

	if ($access_code) {$Body["access_code"] = $access_code}

	if ($preview) {$Body["preview"] = $preview}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Update student question scores and comments. 
.DESCRIPTION
   Update the amount of points a student has scored for questions they've answered, provide comments for the student about their answer(s), or simply fudge the total score by a specific amount of points. Responses See Also:
.EXAMPLE
   PS C:> Put-CanvasCoursesQuizzesSubmissions -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Id $SomeIdObj -attempt $SomeattemptObj -fudge_points $Somefudge_pointsObj -questions $SomequestionsObj
#>
function Put-CanvasCoursesQuizzesSubmissions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The attempt number of the quiz submission that should be updated. This attempt MUST be already completed.
        [Parameter(Mandatory=$true)]
        $attempt,

        # Amount of positive or negative points to fudge the total score by.
        [Parameter(Mandatory=$false)]
        $fudge_points,

        # A set of scores and comments for each question answered by the student. The keys are the question IDs, and the values are hashes of `score` and `comment` entries. See Appendix: Manual Scoring for more on this parameter.
        [Parameter(Mandatory=$false)]
        $questions
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/submissions/{2}" -f $CourseId, $QuizId, $Id 

	$Body = @{}

	$Body["attempt"] = $attempt

	if ($fudge_points) {$Body["fudge_points"] = $fudge_points}

	if ($questions) {$Body["questions"] = $questions}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Complete the quiz submission (turn it in). 
.DESCRIPTION
   Complete the quiz submission by marking it as complete and grading it. When the quiz submission has been marked as complete, no further modifications will be allowed. Responses
.EXAMPLE
   PS C:> Post-CanvasCoursesQuizzesSubmissionsComplete -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Id $SomeIdObj -attempt $SomeattemptObj -validation_token $Somevalidation_tokenObj -access_code $Someaccess_codeObj
#>
function Post-CanvasCoursesQuizzesSubmissionsComplete {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The attempt number of the quiz submission that should be completed. Note that this must be the latest attempt index, as earlier attempts can not be modified.
        [Parameter(Mandatory=$true)]
        $attempt,

        # The unique validation token you received when this Quiz Submission was created.
        [Parameter(Mandatory=$true)]
        $validation_token,

        # Access code for the Quiz, if any.
        [Parameter(Mandatory=$false)]
        $access_code
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/submissions/{2}/complete" -f $CourseId, $QuizId, $Id 

	$Body = @{}

	$Body["attempt"] = $attempt

	$Body["validation_token"] = $validation_token

	if ($access_code) {$Body["access_code"] = $access_code}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Get current quiz submission times. 
.DESCRIPTION
   Get the current timing data for the quiz attempt, both the end_at timestamp and the time_left parameter. Responses
.EXAMPLE
   PS C:> Get-CanvasCoursesQuizzesSubmissionsTime -CourseId $SomeCourseIdObj -QuizId $SomeQuizIdObj -Id $SomeIdObj
#>
function Get-CanvasCoursesQuizzesSubmissionsTime {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The QuizId
        [Parameter(Mandatory=$true)]
        $QuizId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/submissions/{2}/time" -f $CourseId, $QuizId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List quizzes in a course 
.DESCRIPTION
   Returns the list of Quizzes in this course.
.EXAMPLE
   PS C:> Get-CanvasCoursesQuizzes -CourseId $SomeCourseIdObj -search_term $Somesearch_termObj
#>
function Get-CanvasCoursesQuizzes {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The partial title of the quizzes to match and return.
        [Parameter(Mandatory=$false)]
        $search_term
	)

    $uri = "/api/v1/courses/{0}/quizzes" -f $CourseId 

	$Body = @{}

	if ($search_term) {$Body["search_term"] = $search_term}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get a single quiz 
.DESCRIPTION
   Returns the quiz with the given id.
.EXAMPLE
   PS C:> Get-CanvasCoursesQuizzes -CourseId $SomeCourseIdObj -Id $SomeIdObj
#>
function Get-CanvasCoursesQuizzes {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}" -f $CourseId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create a quiz 
.DESCRIPTION
   Create a new quiz for this course.
.EXAMPLE
   PS C:> Post-CanvasCoursesQuizzes -CourseId $SomeCourseIdObj -Title $SomeTitleObj -Description $SomeDescriptionObj -QuizType $SomeQuizTypeObj -AssignmentGroupId $SomeAssignmentGroupIdObj -TimeLimit $SomeTimeLimitObj -ShuffleAnswers $SomeShuffleAnswersObj -HideResults $SomeHideResultsObj -ShowCorrectAnswers $SomeShowCorrectAnswersObj -ShowCorrectAnswersLastAttempt $SomeShowCorrectAnswersLastAttemptObj -ShowCorrectAnswersAt $SomeShowCorrectAnswersAtObj -HideCorrectAnswersAt $SomeHideCorrectAnswersAtObj -AllowedAttempts $SomeAllowedAttemptsObj -ScoringPolicy $SomeScoringPolicyObj -OneQuestionAtATime $SomeOneQuestionAtATimeObj -CantGoBack $SomeCantGoBackObj -AccessCode $SomeAccessCodeObj -IpFilter $SomeIpFilterObj -DueAt $SomeDueAtObj -LockAt $SomeLockAtObj -UnlockAt $SomeUnlockAtObj -Published $SomePublishedObj -OneTimeResults $SomeOneTimeResultsObj -OnlyVisibleToOverrides $SomeOnlyVisibleToOverridesObj
#>
function Post-CanvasCoursesQuizzes {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The quiz title.
        [Parameter(Mandatory=$true)]
        $Title,

        # A description of the quiz.
        [Parameter(Mandatory=$false)]
        $Description,

        # The type of quiz.
		#Allowed values: practice_quiz, assignment, graded_survey, survey 
        [Parameter(Mandatory=$false)]
        $QuizType,

        # The assignment group id to put the assignment in. Defaults to the top assignment group in the course. Only valid if the quiz is graded, i.e. if quiz_type is âassignmentâ or âgraded_surveyâ.
        [Parameter(Mandatory=$false)]
        $AssignmentGroupId,

        # Time limit to take this quiz, in minutes. Set to null for no time limit. Defaults to null.
        [Parameter(Mandatory=$false)]
        $TimeLimit,

        # If true, quiz answers for multiple choice questions will be randomized for each student. Defaults to false.
        [Parameter(Mandatory=$false)]
        $ShuffleAnswers,

        # Dictates whether or not quiz results are hidden from students. If null, students can see their results after any attempt. If âalwaysâ, students can never see their results. If âuntil_after_last_attemptâ, students can only see results after their last attempt. (Only valid if allowed_attempts > 1). Defaults to null.
		#Allowed values: always, until_after_last_attempt 
        [Parameter(Mandatory=$false)]
        $HideResults,

        # Only valid if hide_results=null If false, hides correct answers from students when quiz results are viewed. Defaults to true.
        [Parameter(Mandatory=$false)]
        $ShowCorrectAnswers,

        # Only valid if show_correct_answers=true and allowed_attempts > 1 If true, hides correct answers from students when quiz results are viewed until they submit the last attempt for the quiz. Defaults to false.
        [Parameter(Mandatory=$false)]
        $ShowCorrectAnswersLastAttempt,

        # Only valid if show_correct_answers=true If set, the correct answers will be visible by students only after this date, otherwise the correct answers are visible once the student hands in their quiz submission.
        [Parameter(Mandatory=$false)]
        $ShowCorrectAnswersAt,

        # Only valid if show_correct_answers=true If set, the correct answers will stop being visible once this date has passed. Otherwise, the correct answers will be visible indefinitely.
        [Parameter(Mandatory=$false)]
        $HideCorrectAnswersAt,

        # Number of times a student is allowed to take a quiz. Set to -1 for unlimited attempts. Defaults to 1.
        [Parameter(Mandatory=$false)]
        $AllowedAttempts,

        # Required and only valid if allowed_attempts > 1. Scoring policy for a quiz that students can take multiple times. Defaults to âkeep_highestâ.
		#Allowed values: keep_highest, keep_latest 
        [Parameter(Mandatory=$false)]
        $ScoringPolicy,

        # If true, shows quiz to student one question at a time. Defaults to false.
        [Parameter(Mandatory=$false)]
        $OneQuestionAtATime,

        # Only valid if one_question_at_a_time=true If true, questions are locked after answering. Defaults to false.
        [Parameter(Mandatory=$false)]
        $CantGoBack,

        # Restricts access to the quiz with a password. For no access code restriction, set to null. Defaults to null.
        [Parameter(Mandatory=$false)]
        $AccessCode,

        # Restricts access to the quiz to computers in a specified IP range. Filters can be a comma-separated list of addresses, or an address followed by a mask
		#Examples:
		#"192.168.217.1"
		#"192.168.217.1/24"
		#"192.168.217.1/255.255.255.0"
		#For no IP filter restriction, set to null. Defaults to null.
        [Parameter(Mandatory=$false)]
        $IpFilter,

        # The day/time the quiz is due. Accepts times in ISO 8601 format, e.g. 2011-10-21T18:48Z.
        [Parameter(Mandatory=$false)]
        $DueAt,

        # The day/time the quiz is locked for students. Accepts times in ISO 8601 format, e.g. 2011-10-21T18:48Z.
        [Parameter(Mandatory=$false)]
        $LockAt,

        # The day/time the quiz is unlocked for students. Accepts times in ISO 8601 format, e.g. 2011-10-21T18:48Z.
        [Parameter(Mandatory=$false)]
        $UnlockAt,

        # Whether the quiz should have a draft state of published or unpublished. NOTE: If students have started taking the quiz, or there are any submissions for the quiz, you may not unpublish a quiz and will recieve an error.
        [Parameter(Mandatory=$false)]
        $Published,

        # Whether students should be prevented from viewing their quiz results past the first time (right after they turn the quiz in.) Only valid if âhide_resultsâ is not set to âalwaysâ. Defaults to false.
        [Parameter(Mandatory=$false)]
        $OneTimeResults,

        # Whether this quiz is only visible to overrides (Only useful if 'differentiated assignments' account setting is on) Defaults to false.
        [Parameter(Mandatory=$false)]
        $OnlyVisibleToOverrides
	)

    $uri = "/api/v1/courses/{0}/quizzes" -f $CourseId 

	$Body = @{}

	$Body["quiz[title]"] = $Title

	if ($Description) {$Body["quiz[description]"] = $Description}

	if ($QuizType) {$Body["quiz[quiz_type]"] = $QuizType}

	if ($AssignmentGroupId) {$Body["quiz[assignment_group_id]"] = $AssignmentGroupId}

	if ($TimeLimit) {$Body["quiz[time_limit]"] = $TimeLimit}

	if ($ShuffleAnswers) {$Body["quiz[shuffle_answers]"] = $ShuffleAnswers}

	if ($HideResults) {$Body["quiz[hide_results]"] = $HideResults}

	if ($ShowCorrectAnswers) {$Body["quiz[show_correct_answers]"] = $ShowCorrectAnswers}

	if ($ShowCorrectAnswersLastAttempt) {$Body["quiz[show_correct_answers_last_attempt]"] = $ShowCorrectAnswersLastAttempt}

	if ($ShowCorrectAnswersAt) {$Body["quiz[show_correct_answers_at]"] = $ShowCorrectAnswersAt}

	if ($HideCorrectAnswersAt) {$Body["quiz[hide_correct_answers_at]"] = $HideCorrectAnswersAt}

	if ($AllowedAttempts) {$Body["quiz[allowed_attempts]"] = $AllowedAttempts}

	if ($ScoringPolicy) {$Body["quiz[scoring_policy]"] = $ScoringPolicy}

	if ($OneQuestionAtATime) {$Body["quiz[one_question_at_a_time]"] = $OneQuestionAtATime}

	if ($CantGoBack) {$Body["quiz[cant_go_back]"] = $CantGoBack}

	if ($AccessCode) {$Body["quiz[access_code]"] = $AccessCode}

	if ($IpFilter) {$Body["quiz[ip_filter]"] = $IpFilter}

	if ($DueAt) {$Body["quiz[due_at]"] = $DueAt}

	if ($LockAt) {$Body["quiz[lock_at]"] = $LockAt}

	if ($UnlockAt) {$Body["quiz[unlock_at]"] = $UnlockAt}

	if ($Published) {$Body["quiz[published]"] = $Published}

	if ($OneTimeResults) {$Body["quiz[one_time_results]"] = $OneTimeResults}

	if ($OnlyVisibleToOverrides) {$Body["quiz[only_visible_to_overrides]"] = $OnlyVisibleToOverrides}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Edit a quiz 
.DESCRIPTION
   Modify an existing quiz. See the documentation for quiz creation. Additional arguments:
.EXAMPLE
   PS C:> Put-CanvasCoursesQuizzes -CourseId $SomeCourseIdObj -Id $SomeIdObj -NotifyOfUpdate $SomeNotifyOfUpdateObj
#>
function Put-CanvasCoursesQuizzes {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # If true, notifies users that the quiz has changed. Defaults to true
        [Parameter(Mandatory=$false)]
        $NotifyOfUpdate
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}" -f $CourseId, $Id 

	$Body = @{}

	if ($NotifyOfUpdate) {$Body["quiz[notify_of_update]"] = $NotifyOfUpdate}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Delete a quiz 
.DESCRIPTION
   
.EXAMPLE
   PS C:> Delete-CanvasCoursesQuizzes -CourseId $SomeCourseIdObj -Id $SomeIdObj
#>
function Delete-CanvasCoursesQuizzes {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}" -f $CourseId, $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Reorder quiz items 
.DESCRIPTION
   Change order of the quiz questions or groups within the quiz 204 No Content response code is returned if the reorder was successful.
.EXAMPLE
   PS C:> Post-CanvasCoursesQuizzesReorder -CourseId $SomeCourseIdObj -Id $SomeIdObj -Order[Id] $SomeOrder[Id]Obj -Order[Type] $SomeOrder[Type]Obj
#><#
function Post-CanvasCoursesQuizzesReorder {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The associated item's unique identifier
        [Parameter(Mandatory=$true)]
        $Order[Id],

        # The type of item is either 'question' or 'group'
		#Allowed values: question, group 
        [Parameter(Mandatory=$false)]
        $Order[Type]
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/reorder" -f $CourseId, $Id 

	$Body = @{}

	$Body["order[][id]"] = $Order[Id]

	if ($Order[Type]) {$Body["order[][type]"] = $Order[Type]}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Validate quiz access code 
.DESCRIPTION
   Accepts an access code and returns a boolean indicating whether that access code is correct
.EXAMPLE
   PS C:> Post-CanvasCoursesQuizzesValidateAccessCode -CourseId $SomeCourseIdObj -Id $SomeIdObj -access_code $Someaccess_codeObj
#>
function Post-CanvasCoursesQuizzesValidateAccessCode {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The access code being validated
        [Parameter(Mandatory=$true)]
        $access_code
	)

    $uri = "/api/v1/courses/{0}/quizzes/{1}/validate_access_code" -f $CourseId, $Id 

	$Body = @{}

	$Body["access_code"] = $access_code

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   List roles 
.DESCRIPTION
   List the roles available to an account.
.EXAMPLE
   PS C:> Get-CanvasAccountsRoles -AccountId $SomeAccountIdObj -account_id $Someaccount_idObj -State $SomeStateObj -show_inherited $Someshow_inheritedObj
#>
function Get-CanvasAccountsRoles {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The id of the account to retrieve roles for.
        [Parameter(Mandatory=$true)]
        $account_id,

        # Filter by role state. If this argument is omitted, only 'active' roles are returned.
		#Allowed values: active, inactive 
        [Parameter(Mandatory=$false)]
        $State,

        # If this argument is true, all roles inherited from parent accounts will be included.
        [Parameter(Mandatory=$false)]
        $show_inherited
	)

    $uri = "/api/v1/accounts/{0}/roles" -f $AccountId 

	$Body = @{}

	$Body["account_id"] = $account_id

	if ($State) {$Body["state[]"] = $State}

	if ($show_inherited) {$Body["show_inherited"] = $show_inherited}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get a single role 
.DESCRIPTION
   Retrieve information about a single role
.EXAMPLE
   PS C:> Get-CanvasAccountsRoles -AccountId $SomeAccountIdObj -Id $SomeIdObj -account_id $Someaccount_idObj -role_id $Somerole_idObj -role $SomeroleObj
#>
function Get-CanvasAccountsRoles {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The id of the account containing the role
        [Parameter(Mandatory=$true)]
        $account_id,

        # The unique identifier for the role
        [Parameter(Mandatory=$true)]
        $role_id,

        # The name for the role
        [Parameter(Mandatory=$false)]
        $role
	)

    $uri = "/api/v1/accounts/{0}/roles/{1}" -f $AccountId, $Id 

	$Body = @{}

	$Body["account_id"] = $account_id

	$Body["role_id"] = $role_id

	if ($role) {$Body["role"] = $role}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create a new role 
.DESCRIPTION
   Create a new course-level or account-level role.
.EXAMPLE
   PS C:> Post-CanvasAccountsRoles -AccountId $SomeAccountIdObj -label $SomelabelObj -role $SomeroleObj -base_role_type $Somebase_role_typeObj -Explicit $SomeExplicitObj -Enabled $SomeEnabledObj -Locked $SomeLockedObj -AppliesToSelf $SomeAppliesToSelfObj -AppliesToDescendants $SomeAppliesToDescendantsObj
#>
function Post-CanvasAccountsRoles {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # Label for the role.
        [Parameter(Mandatory=$true)]
        $label,

        # Deprecated alias for label.
        [Parameter(Mandatory=$false)]
        $role,

        # Specifies the role type that will be used as a base for the permissions granted to this role.
		#Defaults to 'AccountMembership' if absent
		#Allowed values: AccountMembership, StudentEnrollment, TeacherEnrollment, TaEnrollment, ObserverEnrollment, DesignerEnrollment 
        [Parameter(Mandatory=$false)]
        $base_role_type,

        # no description
        [Parameter(Mandatory=$false)]
        $Explicit,

        # If explicit is 1 and enabled is 1, permission <X> will be explicitly granted to this role. If explicit is 1 and enabled has any other value (typically 0), permission <X> will be explicitly denied to this role. If explicit is any other value (typically 0) or absent, or if enabled is absent, the value for permission <X> will be inherited from upstream. Ignored if permission <X> is locked upstream (in an ancestor account).
		#May occur multiple times with unique values for <X>. Recognized permission names for <X> are:
		#[For Account-Level Roles Only]
		#become_user                      -- Become other users
		#import_sis                       -- Import SIS data
		#manage_account_memberships       -- Add/remove other admins for the account
		#manage_account_settings          -- Manage account-level settings
		#manage_alerts                    -- Manage global alerts
		#manage_courses                   -- Manage ( add / edit / delete ) courses
		#manage_developer_keys            -- Manage developer keys
		#manage_global_outcomes           -- Manage learning outcomes
		#manage_jobs                      -- Manage background jobs
		#manage_role_overrides            -- Manage permissions
		#manage_storage_quotas            -- Set storage quotas for courses, groups, and users
		#manage_sis                       -- Manage SIS data
		#manage_site_settings             -- Manage site-wide and plugin settings
		#manage_user_logins               -- Modify login details for users
		#read_course_content              -- View course content
		#read_course_list                 -- View the list of courses
		#read_messages                    -- View notifications sent to users
		#site_admin                       -- Use the Site Admin section and admin all other accounts
		#view_error_reports               -- View error reports
		#view_statistics                  -- View statistics
		#manage_feature_flags             -- Enable or disable features at an account level
		#
		#[For both Account-Level and Course-Level roles]
		# Note: Applicable enrollment types for course-level roles are given in brackets:
		#       S = student, T = teacher, A = TA, D = designer, O = observer.
		#       Lower-case letters indicate permissions that are off by default.
		#       A missing letter indicates the permission cannot be enabled for the role
		#       or any derived custom roles.
		#change_course_state              -- [ TaD ] Change course state
		#comment_on_others_submissions    -- [sTAD ] View all students' submissions and make comments on them
		#create_collaborations            -- [STADo] Create student collaborations
		#create_conferences               -- [STADo] Create web conferences
		#manage_admin_users               -- [ Tad ] Add/remove other teachers, course designers or TAs to the course
		#manage_assignments               -- [ TADo] Manage (add / edit / delete) assignments and quizzes
		#manage_calendar                  -- [sTADo] Add, edit and delete events on the course calendar
		#manage_content                   -- [ TADo] Manage all other course content
		#manage_files                     -- [ TADo] Manage (add / edit / delete) course files
		#manage_grades                    -- [ TA  ] Edit grades
		#manage_groups                    -- [ TAD ] Manage (create / edit / delete) groups
		#manage_interaction_alerts        -- [ Ta  ] Manage alerts
		#manage_outcomes                  -- [sTaDo] Manage learning outcomes
		#manage_sections                  -- [ TaD ] Manage (create / edit / delete) course sections
		#manage_students                  -- [ TAD ] Add/remove students for the course
		#manage_user_notes                -- [ TA  ] Manage faculty journal entries
		#manage_rubrics                   -- [ TAD ] Edit assessing rubrics
		#manage_wiki                      -- [ TADo] Manage (add / edit / delete) pages
		#read_forum                       -- [STADO] View discussions
		#moderate_forum                   -- [sTADo] Moderate discussions (delete/edit others' posts, lock topics)
		#post_to_forum                    -- [STADo] Post to discussions
		#read_announcements               -- [STADO] View announcements
		#read_question_banks              -- [ TADo] View and link to question banks
		#read_reports                     -- [ TAD ] View usage reports for the course
		#read_roster                      -- [STADo] See the list of users
		#read_sis                         -- [sTa  ] Read SIS data
		#send_messages                    -- [STADo] Send messages to individual course members
		#send_messages_all                -- [sTADo] Send messages to the entire class
		#view_all_grades                  -- [ TAd ] View all grades
		#view_group_pages                 -- [sTADo] View the group pages of all student groups
		#lti_add_edit                     -- [ TAD ] LTI add and editSome of these permissions are applicable only for roles on the site admin account, on a root account, or for course-level roles with a particular base role type; if a specified permission is inapplicable, it will be ignored.
		#Additional permissions may exist based on installed plugins.
        [Parameter(Mandatory=$false)]
        $Enabled,

        # If the value is 1, permission <X> will be locked downstream (new roles in subaccounts cannot override the setting). For any other value, permission <X> is left unlocked. Ignored if permission <X> is already locked upstream. May occur multiple times with unique values for <X>.
        [Parameter(Mandatory=$false)]
        $Locked,

        # If the value is 1, permission <X> applies to the account this role is in. The default value is 1. Must be true if applies_to_descendants is false. This value is only returned if enabled is true.
        [Parameter(Mandatory=$false)]
        $AppliesToSelf,

        # If the value is 1, permission <X> cascades down to sub accounts of the account this role is in. The default value is 1. Must be true if applies_to_self is false.This value is only returned if enabled is true.
        [Parameter(Mandatory=$false)]
        $AppliesToDescendants
	)

    $uri = "/api/v1/accounts/{0}/roles" -f $AccountId 

	$Body = @{}

	$Body["label"] = $label

	if ($role) {$Body["role"] = $role}

	if ($base_role_type) {$Body["base_role_type"] = $base_role_type}

	if ($Explicit) {$Body["permissions[<X>][explicit]"] = $Explicit}

	if ($Enabled) {$Body["permissions[<X>][enabled]"] = $Enabled}

	if ($Locked) {$Body["permissions[<X>][locked]"] = $Locked}

	if ($AppliesToSelf) {$Body["permissions[<X>][applies_to_self]"] = $AppliesToSelf}

	if ($AppliesToDescendants) {$Body["permissions[<X>][applies_to_descendants]"] = $AppliesToDescendants}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Deactivate a role 
.DESCRIPTION
   Deactivates a custom role. This hides it in the user interface and prevents it from being assigned to new users. Existing users assigned to the role will continue to function with the same permissions they had previously. Built-in roles cannot be deactivated.
.EXAMPLE
   PS C:> Delete-CanvasAccountsRoles -AccountId $SomeAccountIdObj -Id $SomeIdObj -role_id $Somerole_idObj -role $SomeroleObj
#>
function Delete-CanvasAccountsRoles {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The unique identifier for the role
        [Parameter(Mandatory=$true)]
        $role_id,

        # The name for the role
        [Parameter(Mandatory=$false)]
        $role
	)

    $uri = "/api/v1/accounts/{0}/roles/{1}" -f $AccountId, $Id 

	$Body = @{}

	$Body["role_id"] = $role_id

	if ($role) {$Body["role"] = $role}

    return Get-CanvasApiResult $uri -Method DELETE -RequestParameters $Body
}


<#
.Synopsis
   Activate a role 
.DESCRIPTION
   Re-activates an inactive role (allowing it to be assigned to new users)
.EXAMPLE
   PS C:> Post-CanvasAccountsRolesActivate -AccountId $SomeAccountIdObj -Id $SomeIdObj -role_id $Somerole_idObj -role $SomeroleObj
#>
function Post-CanvasAccountsRolesActivate {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The unique identifier for the role
        [Parameter(Mandatory=$true)]
        $role_id,

        # The name for the role
        [Parameter(Mandatory=$false)]
        $role
	)

    $uri = "/api/v1/accounts/{0}/roles/{1}/activate" -f $AccountId, $Id 

	$Body = @{}

	$Body["role_id"] = $role_id

	if ($role) {$Body["role"] = $role}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Update a role 
.DESCRIPTION
   Update permissions for an existing role. Recognized roles are:
.EXAMPLE
   PS C:> Put-CanvasAccountsRoles -AccountId $SomeAccountIdObj -Id $SomeIdObj -label $SomelabelObj -Explicit $SomeExplicitObj -Enabled $SomeEnabledObj -AppliesToSelf $SomeAppliesToSelfObj -AppliesToDescendants $SomeAppliesToDescendantsObj
#>
function Put-CanvasAccountsRoles {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The label for the role. Can only change the label of a custom role that belongs directly to the account.
        [Parameter(Mandatory=$false)]
        $label,

        # no description
        [Parameter(Mandatory=$false)]
        $Explicit,

        # These arguments are described in the documentation for the add_role method.
        [Parameter(Mandatory=$false)]
        $Enabled,

        # If the value is 1, permission <X> applies to the account this role is in. The default value is 1. Must be true if applies_to_descendants is false. This value is only returned if enabled is true.
        [Parameter(Mandatory=$false)]
        $AppliesToSelf,

        # If the value is 1, permission <X> cascades down to sub accounts of the account this role is in. The default value is 1. Must be true if applies_to_self is false.This value is only returned if enabled is true.
        [Parameter(Mandatory=$false)]
        $AppliesToDescendants
	)

    $uri = "/api/v1/accounts/{0}/roles/{1}" -f $AccountId, $Id 

	$Body = @{}

	if ($label) {$Body["label"] = $label}

	if ($Explicit) {$Body["permissions[<X>][explicit]"] = $Explicit}

	if ($Enabled) {$Body["permissions[<X>][enabled]"] = $Enabled}

	if ($AppliesToSelf) {$Body["permissions[<X>][applies_to_self]"] = $AppliesToSelf}

	if ($AppliesToDescendants) {$Body["permissions[<X>][applies_to_descendants]"] = $AppliesToDescendants}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   List rubrics 
.DESCRIPTION
   Returns the paginated list of active rubrics for the current context.
.EXAMPLE
   PS C:> Get-CanvasAccountsRubrics -AccountId $SomeAccountIdObj
#>
function Get-CanvasAccountsRubrics {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId
	)

    $uri = "/api/v1/accounts/{0}/rubrics" -f $AccountId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get a single rubric 
.DESCRIPTION
   Returns the rubric with the given id.
.EXAMPLE
   PS C:> Get-CanvasAccountsRubrics -AccountId $SomeAccountIdObj -Id $SomeIdObj -include $SomeincludeObj -style $SomestyleObj
#>
function Get-CanvasAccountsRubrics {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # If included, the type of associated rubric assessments to return. If not included, assessments will be omitted.
		#Allowed values: assessments, graded_assessments, peer_assessments 
        [Parameter(Mandatory=$false)]
        $include,

        # Applicable only if assessments are being returned. If included, returns either all criteria data associated with the assessment, or just the comments. If not included, both data and comments are omitted.
		#Allowed values: full, comments_only 
        [Parameter(Mandatory=$false)]
        $style
	)

    $uri = "/api/v1/accounts/{0}/rubrics/{1}" -f $AccountId, $Id 

	$Body = @{}

	if ($include) {$Body["include"] = $include}

	if ($style) {$Body["style"] = $style}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get SIS import list 
.DESCRIPTION
   Returns the list of SIS imports for an account Example:
.EXAMPLE
   PS C:> Get-CanvasAccountsSisImports -AccountId $SomeAccountIdObj -created_since $Somecreated_sinceObj
#>
function Get-CanvasAccountsSisImports {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # If set, only shows imports created after the specified date (use ISO8601 format)
        [Parameter(Mandatory=$false)]
        $created_since
	)

    $uri = "/api/v1/accounts/{0}/sis_imports" -f $AccountId 

	$Body = @{}

	if ($created_since) {$Body["created_since"] = $created_since}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Import SIS data 
.DESCRIPTION
   Import SIS data into Canvas. Must be on a root account with SIS imports enabled. For more information on the format that's expected here, please see the âSIS CSVâ section in the API docs.
.EXAMPLE
   PS C:> Post-CanvasAccountsSisImports -AccountId $SomeAccountIdObj -import_type $Someimport_typeObj -attachment $SomeattachmentObj -extension $SomeextensionObj -batch_mode $Somebatch_modeObj -batch_mode_term_id $Somebatch_mode_term_idObj -override_sis_stickiness $Someoverride_sis_stickinessObj -add_sis_stickiness $Someadd_sis_stickinessObj -clear_sis_stickiness $Someclear_sis_stickinessObj -diffing_data_set_identifier $Somediffing_data_set_identifierObj -diffing_remaster_data_set $Somediffing_remaster_data_setObj
#>
function Post-CanvasAccountsSisImports {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # Choose the data format for reading SIS data. With a standard Canvas install, this option can only be 'instructure_csv', and if unprovided, will be assumed to be so. Can be part of the query string.
        [Parameter(Mandatory=$false)]
        $import_type,

        # There are two ways to post SIS import data - either via a multipart/form-data form-field-style attachment, or via a non-multipart raw post request.
		#'attachment' is required for multipart/form-data style posts. Assumed to be SIS data from a file upload form field named 'attachment'.
		#Examples:
		#curl -F attachment=@<filename> -H "Authorization: Bearer <token>" \
		#    'https://<canvas>/api/v1/accounts/<account_id>/sis_imports.json?import_type=instructure_csv'If you decide to do a raw post, you can skip the 'attachment' argument, but you will then be required to provide a suitable Content-Type header. You are encouraged to also provide the 'extension' argument.
		#Examples:
		#curl -H 'Content-Type: application/octet-stream' --data-binary @<filename>.zip \
		#    -H "Authorization: Bearer <token>" \
		#    'https://<canvas>/api/v1/accounts/<account_id>/sis_imports.json?import_type=instructure_csv&extension=zip'
		#
		#curl -H 'Content-Type: application/zip' --data-binary @<filename>.zip \
		#    -H "Authorization: Bearer <token>" \
		#    'https://<canvas>/api/v1/accounts/<account_id>/sis_imports.json?import_type=instructure_csv'
		#
		#curl -H 'Content-Type: text/csv' --data-binary @<filename>.csv \
		#    -H "Authorization: Bearer <token>" \
		#    'https://<canvas>/api/v1/accounts/<account_id>/sis_imports.json?import_type=instructure_csv'
		#
		#curl -H 'Content-Type: text/csv' --data-binary @<filename>.csv \
		#    -H "Authorization: Bearer <token>" \
		#    'https://<canvas>/api/v1/accounts/<account_id>/sis_imports.json?import_type=instructure_csv&batch_mode=1&batch_mode_term_id=15'
        [Parameter(Mandatory=$false)]
        $attachment,

        # Recommended for raw post request style imports. This field will be used to distinguish between zip, xml, csv, and other file format extensions that would usually be provided with the filename in the multipart post request scenario. If not provided, this value will be inferred from the Content-Type, falling back to zip-file format if all else fails.
        [Parameter(Mandatory=$false)]
        $extension,

        # If set, this SIS import will be run in batch mode, deleting any data previously imported via SIS that is not present in this latest import. See the SIS CSV Format page for details.
        [Parameter(Mandatory=$false)]
        $batch_mode,

        # Limit deletions to only this term. Required if batch mode is enabled.
        [Parameter(Mandatory=$false)]
        $batch_mode_term_id,

        # Many fields on records in Canvas can be marked âsticky,â which means that when something changes in the UI apart from the SIS, that field gets âstuck.â In this way, by default, SIS imports do not override UI changes. If this field is present, however, it will tell the SIS import to ignore âstickinessâ and override all fields.
        [Parameter(Mandatory=$false)]
        $override_sis_stickiness,

        # This option, if present, will process all changes as if they were UI changes. This means that âstickinessâ will be added to changed fields. This option is only processed if 'override_sis_stickiness' is also provided.
        [Parameter(Mandatory=$false)]
        $add_sis_stickiness,

        # This option, if present, will clear âstickinessâ from all fields touched by this import. Requires that 'override_sis_stickiness' is also provided. If 'add_sis_stickiness' is also provided, 'clear_sis_stickiness' will overrule the behavior of 'add_sis_stickiness'
        [Parameter(Mandatory=$false)]
        $clear_sis_stickiness,

        # If set on a CSV import, Canvas will attempt to optimize the SIS import by comparing this set of CSVs to the previous set that has the same data set identifier, and only appliying the difference between the two. See the SIS CSV Format documentation for more details.
        [Parameter(Mandatory=$false)]
        $diffing_data_set_identifier,

        # If true, and diffing_data_set_identifier is sent, this SIS import will be part of the data set, but diffing will not be performed. See the SIS CSV Format documentation for details.
        [Parameter(Mandatory=$false)]
        $diffing_remaster_data_set
	)

    $uri = "/api/v1/accounts/{0}/sis_imports" -f $AccountId 

	$Body = @{}

	if ($import_type) {$Body["import_type"] = $import_type}

	if ($attachment) {$Body["attachment"] = $attachment}

	if ($extension) {$Body["extension"] = $extension}

	if ($batch_mode) {$Body["batch_mode"] = $batch_mode}

	if ($batch_mode_term_id) {$Body["batch_mode_term_id"] = $batch_mode_term_id}

	if ($override_sis_stickiness) {$Body["override_sis_stickiness"] = $override_sis_stickiness}

	if ($add_sis_stickiness) {$Body["add_sis_stickiness"] = $add_sis_stickiness}

	if ($clear_sis_stickiness) {$Body["clear_sis_stickiness"] = $clear_sis_stickiness}

	if ($diffing_data_set_identifier) {$Body["diffing_data_set_identifier"] = $diffing_data_set_identifier}

	if ($diffing_remaster_data_set) {$Body["diffing_remaster_data_set"] = $diffing_remaster_data_set}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Get SIS import status 
.DESCRIPTION
   Get the status of an already created SIS import.
.EXAMPLE
   PS C:> Get-CanvasAccountsSisImports -AccountId $SomeAccountIdObj -Id $SomeIdObj
#>
function Get-CanvasAccountsSisImports {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/accounts/{0}/sis_imports/{1}" -f $AccountId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Abort SIS import 
.DESCRIPTION
   Abort an already created but not processed or processing SIS import.
.EXAMPLE
   PS C:> Put-CanvasAccountsSisImportsAbort -AccountId $SomeAccountIdObj -Id $SomeIdObj
#>
function Put-CanvasAccountsSisImportsAbort {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/accounts/{0}/sis_imports/{1}/abort" -f $AccountId, $Id 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Abort all pending SIS imports 
.DESCRIPTION
   Abort already created but not processed or processing SIS imports.
.EXAMPLE
   PS C:> Put-CanvasAccountsSisImportsAbortAllPending -AccountId $SomeAccountIdObj
#>
function Put-CanvasAccountsSisImportsAbortAllPending {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId
	)

    $uri = "/api/v1/accounts/{0}/sis_imports/abort_all_pending" -f $AccountId 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Retrieve assignments enabled for grade export to SIS 
.DESCRIPTION
   Retrieve a list of published assignments flagged as âpost_to_sisâ. Assignment group and section information are included for convenience. Each section includes course information for the origin course and the cross-listed course, if applicable. The `origin_course` is the course to which the section belongs or the course from which the section was cross-listed. Generally, the `origin_course` should be preferred when performing integration work. The `xlist_course` is provided for consistency and is only present when the section has been cross-listed. The `override` is only provided if the Differentiated Assignments course feature is turned on and the assignment has an override for that section. When there is an override for the assignment the override object's keys/values can be merged with the top level assignment object to create a view of the assignment object specific to that section.
.EXAMPLE
   PS C:> Get-CanvasApiSisAccountsAssignments -AccountId $SomeAccountIdObj -account_id $Someaccount_idObj -course_id $Somecourse_idObj -starts_before $Somestarts_beforeObj -ends_after $Someends_afterObj
#>
function Get-CanvasApiSisAccountsAssignments {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The ID of the account to query.
        [Parameter(Mandatory=$false)]
        $account_id,

        # The ID of the course to query.
        [Parameter(Mandatory=$false)]
        $course_id,

        # When searching on an account, restricts to courses that start before this date (if they have a start date)
        [Parameter(Mandatory=$false)]
        $starts_before,

        # When searching on an account, restricts to courses that end after this date (if they have an end date)
        [Parameter(Mandatory=$false)]
        $ends_after
	)

    $uri = "/api/sis/accounts/{0}/assignments" -f $AccountId 

	$Body = @{}

	if ($account_id) {$Body["account_id"] = $account_id}

	if ($course_id) {$Body["course_id"] = $course_id}

	if ($starts_before) {$Body["starts_before"] = $starts_before}

	if ($ends_after) {$Body["ends_after"] = $ends_after}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Find recipients 
.DESCRIPTION
   Find valid recipients (users, courses and groups) that the current user can send messages to. The /api/v1/search/recipients path is the preferred endpoint, /api/v1/conversations/find_recipients is deprecated. Pagination is supported.
.EXAMPLE
   PS C:> Get-CanvasConversationsFindRecipients -search $SomesearchObj -context $SomecontextObj -Exclude $SomeExcludeObj -type $SometypeObj -user_id $Someuser_idObj -from_conversation_id $Somefrom_conversation_idObj -Permissions $SomePermissionsObj
#>
function Get-CanvasConversationsFindRecipients {
[CmdletBinding()]

	Param
	(
        # Search terms used for matching users/courses/groups (e.g. âbob smithâ). If multiple terms are given (separated via whitespace), only results matching all terms will be returned.
        [Parameter(Mandatory=$false)]
        $search,

        # Limit the search to a particular course/group (e.g. âcourse_3â or âgroup_4â).
        [Parameter(Mandatory=$false)]
        $context,

        # Array of ids to exclude from the search. These may be user ids or course/group ids prefixed with âcourse_â or âgroup_â respectively, e.g. exclude[]=1&exclude=2&exclude[]=course_3
        [Parameter(Mandatory=$false)]
        $Exclude,

        # Limit the search just to users or contexts (groups/courses).
		#Allowed values: user, context 
        [Parameter(Mandatory=$false)]
        $type,

        # Search for a specific user id. This ignores the other above parameters, and will never return more than one result.
        [Parameter(Mandatory=$false)]
        $user_id,

        # When searching by user_id, only users that could be normally messaged by this user will be returned. This parameter allows you to specify a conversation that will be referenced for a shared context â if both the current user and the searched user are in the conversation, the user will be returned. This is used to start new side conversations.
        [Parameter(Mandatory=$false)]
        $from_conversation_id,

        # Array of permission strings to be checked for each matched context (e.g. âsend_messagesâ). This argument determines which permissions may be returned in the response; it won't prevent contexts from being returned if they don't grant the permission(s).
        [Parameter(Mandatory=$false)]
        $Permissions
	)

    $uri = "/api/v1/conversations/find_recipients" 

	$Body = @{}

	if ($search) {$Body["search"] = $search}

	if ($context) {$Body["context"] = $context}

	if ($Exclude) {$Body["exclude[]"] = $Exclude}

	if ($type) {$Body["type"] = $type}

	if ($user_id) {$Body["user_id"] = $user_id}

	if ($from_conversation_id) {$Body["from_conversation_id"] = $from_conversation_id}

	if ($Permissions) {$Body["permissions[]"] = $Permissions}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List all courses 
.DESCRIPTION
   List all courses visible in the public index
.EXAMPLE
   PS C:> Get-CanvasSearchAllCourses -search $SomesearchObj -public_only $Somepublic_onlyObj -open_enrollment_only $Someopen_enrollment_onlyObj
#>
function Get-CanvasSearchAllCourses {
[CmdletBinding()]

	Param
	(
        # Search terms used for matching users/courses/groups (e.g. âbob smithâ). If multiple terms are given (separated via whitespace), only results matching all terms will be returned.
        [Parameter(Mandatory=$false)]
        $search,

        # Only return courses with public content. Defaults to false.
        [Parameter(Mandatory=$false)]
        $public_only,

        # Only return courses that allow self enrollment. Defaults to false.
        [Parameter(Mandatory=$false)]
        $open_enrollment_only
	)

    $uri = "/api/v1/search/all_courses" 

	$Body = @{}

	if ($search) {$Body["search"] = $search}

	if ($public_only) {$Body["public_only"] = $public_only}

	if ($open_enrollment_only) {$Body["open_enrollment_only"] = $open_enrollment_only}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List course sections 
.DESCRIPTION
   Returns the list of sections for this course.
.EXAMPLE
   PS C:> Get-CanvasCoursesSections -CourseId $SomeCourseIdObj -Include $SomeIncludeObj
#>
function Get-CanvasCoursesSections {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # âstudentsâ: Associations to include with the group. Note: this is only available if you have permission to view users or grades in the course
		#âavatar_urlâ: Include the avatar URLs for students returned.
		#âenrollmentsâ: If 'students' is also included, return the section enrollment for each student
		#âtotal_studentsâ: Returns the total amount of active and invited students for the course section
		#âpassback_statusâ: Include the grade passback status.
		#Allowed values: students, avatar_url, enrollments, total_students, passback_status 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/courses/{0}/sections" -f $CourseId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Create course section 
.DESCRIPTION
   Creates a new section for this course.
.EXAMPLE
   PS C:> Post-CanvasCoursesSections -CourseId $SomeCourseIdObj -Name $SomeNameObj -SisSectionId $SomeSisSectionIdObj -StartAt $SomeStartAtObj -EndAt $SomeEndAtObj -RestrictEnrollmentsToSectionDates $SomeRestrictEnrollmentsToSectionDatesObj -enable_sis_reactivation $Someenable_sis_reactivationObj
#>
function Post-CanvasCoursesSections {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The name of the section
        [Parameter(Mandatory=$false)]
        $Name,

        # The sis ID of the section
        [Parameter(Mandatory=$false)]
        $SisSectionId,

        # Section start date in ISO8601 format, e.g. 2011-01-01T01:00Z
        [Parameter(Mandatory=$false)]
        $StartAt,

        # Section end date in ISO8601 format. e.g. 2011-01-01T01:00Z
        [Parameter(Mandatory=$false)]
        $EndAt,

        # Set to true to restrict user enrollments to the start and end dates of the section.
        [Parameter(Mandatory=$false)]
        $RestrictEnrollmentsToSectionDates,

        # When true, will first try to re-activate a deleted section with matching sis_section_id if possible.
        [Parameter(Mandatory=$false)]
        $enable_sis_reactivation
	)

    $uri = "/api/v1/courses/{0}/sections" -f $CourseId 

	$Body = @{}

	if ($Name) {$Body["course_section[name]"] = $Name}

	if ($SisSectionId) {$Body["course_section[sis_section_id]"] = $SisSectionId}

	if ($StartAt) {$Body["course_section[start_at]"] = $StartAt}

	if ($EndAt) {$Body["course_section[end_at]"] = $EndAt}

	if ($RestrictEnrollmentsToSectionDates) {$Body["course_section[restrict_enrollments_to_section_dates]"] = $RestrictEnrollmentsToSectionDates}

	if ($enable_sis_reactivation) {$Body["enable_sis_reactivation"] = $enable_sis_reactivation}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Cross-list a Section 
.DESCRIPTION
   Move the Section to another course. The new course may be in a different account (department), but must belong to the same root account (institution).
.EXAMPLE
   PS C:> Post-CanvasSectionsCrosslist -Id $SomeIdObj -NewCourseId $SomeNewCourseIdObj
#>
function Post-CanvasSectionsCrosslist {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The NewCourseId
        [Parameter(Mandatory=$true)]
        $NewCourseId
	)

    $uri = "/api/v1/sections/{0}/crosslist/{1}" -f $Id, $NewCourseId 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   De-cross-list a Section 
.DESCRIPTION
   Undo cross-listing of a Section, returning it to its original course.
.EXAMPLE
   PS C:> Delete-CanvasSectionsCrosslist -Id $SomeIdObj
#>
function Delete-CanvasSectionsCrosslist {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/sections/{0}/crosslist" -f $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Edit a section 
.DESCRIPTION
   Modify an existing section.
.EXAMPLE
   PS C:> Put-CanvasSections -Id $SomeIdObj -Name $SomeNameObj -SisSectionId $SomeSisSectionIdObj -StartAt $SomeStartAtObj -EndAt $SomeEndAtObj -RestrictEnrollmentsToSectionDates $SomeRestrictEnrollmentsToSectionDatesObj
#>
function Put-CanvasSections {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The name of the section
        [Parameter(Mandatory=$false)]
        $Name,

        # The sis ID of the section
        [Parameter(Mandatory=$false)]
        $SisSectionId,

        # Section start date in ISO8601 format, e.g. 2011-01-01T01:00Z
        [Parameter(Mandatory=$false)]
        $StartAt,

        # Section end date in ISO8601 format. e.g. 2011-01-01T01:00Z
        [Parameter(Mandatory=$false)]
        $EndAt,

        # Set to true to restrict user enrollments to the start and end dates of the section.
        [Parameter(Mandatory=$false)]
        $RestrictEnrollmentsToSectionDates
	)

    $uri = "/api/v1/sections/{0}" -f $Id 

	$Body = @{}

	if ($Name) {$Body["course_section[name]"] = $Name}

	if ($SisSectionId) {$Body["course_section[sis_section_id]"] = $SisSectionId}

	if ($StartAt) {$Body["course_section[start_at]"] = $StartAt}

	if ($EndAt) {$Body["course_section[end_at]"] = $EndAt}

	if ($RestrictEnrollmentsToSectionDates) {$Body["course_section[restrict_enrollments_to_section_dates]"] = $RestrictEnrollmentsToSectionDates}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Get section information 
.DESCRIPTION
   Gets details about a specific section
.EXAMPLE
   PS C:> Get-CanvasCoursesSections -CourseId $SomeCourseIdObj -Id $SomeIdObj -Include $SomeIncludeObj
#>
function Get-CanvasCoursesSections {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # âstudentsâ: Associations to include with the group. Note: this is only available if you have permission to view users or grades in the course
		#âavatar_urlâ: Include the avatar URLs for students returned.
		#âenrollmentsâ: If 'students' is also included, return the section enrollment for each student
		#âtotal_studentsâ: Returns the total amount of active and invited students for the course section
		#âpassback_statusâ: Include the grade passback status.
		#Allowed values: students, avatar_url, enrollments, total_students, passback_status 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/courses/{0}/sections/{1}" -f $CourseId, $Id 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Delete a section 
.DESCRIPTION
   Delete an existing section. Returns the former Section.
.EXAMPLE
   PS C:> Delete-CanvasSections -Id $SomeIdObj
#>
function Delete-CanvasSections {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/sections/{0}" -f $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Get Kaltura config 
.DESCRIPTION
   Return the config information for the Kaltura plugin in json format.
.EXAMPLE
   PS C:> Get-CanvasServicesKaltura
#>
function Get-CanvasServicesKaltura {
[CmdletBinding()]

    $uri = "/api/v1/services/kaltura" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Start Kaltura session 
.DESCRIPTION
   Start a new Kaltura session, so that new media can be recorded and uploaded to this Canvas instance's Kaltura instance.
.EXAMPLE
   PS C:> Post-CanvasServicesKalturaSession
#>
function Post-CanvasServicesKalturaSession {
[CmdletBinding()]

    $uri = "/api/v1/services/kaltura_session" 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   Share a BrandConfig (Theme) 
.DESCRIPTION
   Create a SharedBrandConfig, which will give the given brand_config a name and make it available to other users of this account.
.EXAMPLE
   PS C:> Post-CanvasAccountsSharedBrandConfigs -AccountId $SomeAccountIdObj -Name $SomeNameObj -BrandConfigMd5 $SomeBrandConfigMd5Obj
#>
function Post-CanvasAccountsSharedBrandConfigs {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # Name to share this BrandConfig (theme) as.
        [Parameter(Mandatory=$true)]
        $Name,

        # MD5 of brand_config to share
        [Parameter(Mandatory=$true)]
        $BrandConfigMd5
	)

    $uri = "/api/v1/accounts/{0}/shared_brand_configs" -f $AccountId 

	$Body = @{}

	$Body["shared_brand_config[name]"] = $Name

	$Body["shared_brand_config[brand_config_md5]"] = $BrandConfigMd5

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Update a shared theme 
.DESCRIPTION
   Update the specified shared_brand_config with a new name or to point to a new brand_config. Uses same parameters as create.
.EXAMPLE
   PS C:> Put-CanvasAccountsSharedBrandConfigs -AccountId $SomeAccountIdObj -Id $SomeIdObj
#>
function Put-CanvasAccountsSharedBrandConfigs {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/accounts/{0}/shared_brand_configs/{1}" -f $AccountId, $Id 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Un-share a BrandConfig (Theme) 
.DESCRIPTION
   Delete a SharedBrandConfig, which will unshare it so you nor anyone else in your account will see it as an option to pick from.
.EXAMPLE
   PS C:> Delete-CanvasSharedBrandConfigs -Id $SomeIdObj
#>
function Delete-CanvasSharedBrandConfigs {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/shared_brand_configs/{0}" -f $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Upload a file 
.DESCRIPTION
   Upload a file to attach to a submission comment See the File Upload Documentation for details on the file upload workflow. The final step of the file upload workflow will return the attachment data, including the new file id. The caller can then PUT the file_id to the submission API to attach it to a comment
.EXAMPLE
   PS C:> Post-CanvasCoursesAssignmentsSubmissionsCommentsFiles -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -UserId $SomeUserIdObj
#>
function Post-CanvasCoursesAssignmentsSubmissionsCommentsFiles {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/submissions/{2}/comments/files" -f $CourseId, $AssignmentId, $UserId 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   Submit an assignment 
.DESCRIPTION
   Make a submission for an assignment. You must be enrolled as a student in the course/section to do this. All online turn-in submission types are supported in this API. However, there are a few things that are not yet supported:
.EXAMPLE
   PS C:> Post-CanvasCoursesAssignmentsSubmissions -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -TextComment $SomeTextCommentObj -SubmissionType $SomeSubmissionTypeObj -Body $SomeBodyObj -Url $SomeUrlObj -Submission[FileIds] $SomeSubmission[FileIds]Obj -MediaCommentId $SomeMediaCommentIdObj -MediaCommentType $SomeMediaCommentTypeObj
#><#
function Post-CanvasCoursesAssignmentsSubmissions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # Include a textual comment with the submission.
        [Parameter(Mandatory=$false)]
        $TextComment,

        # The type of submission being made. The assignment submission_types must include this submission type as an allowed option, or the submission will be rejected with a 400 error.
		#The submission_type given determines which of the following parameters is used. For instance, to submit a URL, submission [submission_type] must be set to âonline_urlâ, otherwise the submission [url] parameter will be ignored.
		#Allowed values: online_text_entry, online_url, online_upload, media_recording, basic_lti_launch 
        [Parameter(Mandatory=$true)]
        $SubmissionType,

        # Submit the assignment as an HTML document snippet. Note this HTML snippet will be sanitized using the same ruleset as a submission made from the Canvas web UI. The sanitized HTML will be returned in the response as the submission body. Requires a submission_type of âonline_text_entryâ.
        [Parameter(Mandatory=$false)]
        $Body,

        # Submit the assignment as a URL. The URL scheme must be âhttpâ or âhttpsâ, no âftpâ or other URL schemes are allowed. If no scheme is given (e.g. âwww.example.comâ) then âhttpâ will be assumed. Requires a submission_type of âonline_urlâ or âbasic_lti_launchâ.
        [Parameter(Mandatory=$false)]
        $Url,

        # Submit the assignment as a set of one or more previously uploaded files residing in the submitting user's files section (or the group's files section, for group assignments).
		#To upload a new file to submit, see the submissions Upload a file API.
		#Requires a submission_type of âonline_uploadâ.
        [Parameter(Mandatory=$false)]
        $Submission[FileIds],

        # The media comment id to submit. Media comment ids can be submitted via this API, however, note that there is not yet an API to generate or list existing media comments, so this functionality is currently of limited use.
		#Requires a submission_type of âmedia_recordingâ.
        [Parameter(Mandatory=$false)]
        $MediaCommentId,

        # The type of media comment being submitted.
		#Allowed values: audio, video 
        [Parameter(Mandatory=$false)]
        $MediaCommentType
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/submissions" -f $CourseId, $AssignmentId 

	$Body = @{}

	if ($TextComment) {$Body["comment[text_comment]"] = $TextComment}

	$Body["submission[submission_type]"] = $SubmissionType

	if ($Body) {$Body["submission[body]"] = $Body}

	if ($Url) {$Body["submission[url]"] = $Url}

	if ($Submission[FileIds]) {$Body["submission[file_ids][]"] = $Submission[FileIds]}

	if ($MediaCommentId) {$Body["submission[media_comment_id]"] = $MediaCommentId}

	if ($MediaCommentType) {$Body["submission[media_comment_type]"] = $MediaCommentType}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   List assignment submissions 
.DESCRIPTION
   Get all existing submissions for an assignment.
.EXAMPLE
   PS C:> Get-CanvasCoursesAssignmentsSubmissions -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -Include $SomeIncludeObj -grouped $SomegroupedObj
#>
function Get-CanvasCoursesAssignmentsSubmissions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # Associations to include with the group. âgroupâ will add group_id and group_name.
		#Allowed values: submission_history, submission_comments, rubric_assessment, assignment, visibility, course, user, group 
        [Parameter(Mandatory=$false)]
        $Include,

        # If this argument is true, the response will be grouped by student groups.
        [Parameter(Mandatory=$false)]
        $grouped
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/submissions" -f $CourseId, $AssignmentId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

	if ($grouped) {$Body["grouped"] = $grouped}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List submissions for multiple assignments 
.DESCRIPTION
   Get all existing submissions for a given set of students and assignments.
.EXAMPLE
   PS C:> Get-CanvasCoursesStudentsSubmissions -CourseId $SomeCourseIdObj -StudentIds $SomeStudentIdsObj -AssignmentIds $SomeAssignmentIdsObj -grouped $SomegroupedObj -grading_period_id $Somegrading_period_idObj -order $SomeorderObj -order_direction $Someorder_directionObj -Include $SomeIncludeObj
#>
function Get-CanvasCoursesStudentsSubmissions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # List of student ids to return submissions for. If this argument is omitted, return submissions for the calling user. Students may only list their own submissions. Observers may only list those of associated students. The special id âallâ will return submissions for all students in the course/section as appropriate.
        [Parameter(Mandatory=$false)]
        $StudentIds,

        # List of assignments to return submissions for. If none are given, submissions for all assignments are returned.
        [Parameter(Mandatory=$false)]
        $AssignmentIds,

        # If this argument is present, the response will be grouped by student, rather than a flat array of submissions.
        [Parameter(Mandatory=$false)]
        $grouped,

        # The id of the grading period in which submissions are being requested (Requires the Multiple Grading Periods account feature turned on)
        [Parameter(Mandatory=$false)]
        $grading_period_id,

        # The order submissions will be returned in. Defaults to âidâ. Doesn't affect results for âgroupedâ mode.
		#Allowed values: id, graded_at 
        [Parameter(Mandatory=$false)]
        $order,

        # Determines whether ordered results are retured in ascending or descending order. Defaults to âascendingâ. Doesn't affect results for âgroupedâ mode.
		#Allowed values: ascending, descending 
        [Parameter(Mandatory=$false)]
        $order_direction,

        # Associations to include with the group. `total_scores` requires the `grouped` argument.
		#Allowed values: submission_history, submission_comments, rubric_assessment, assignment, total_scores, visibility, course, user 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/courses/{0}/students/submissions" -f $CourseId 

	$Body = @{}

	if ($StudentIds) {$Body["student_ids[]"] = $StudentIds}

	if ($AssignmentIds) {$Body["assignment_ids[]"] = $AssignmentIds}

	if ($grouped) {$Body["grouped"] = $grouped}

	if ($grading_period_id) {$Body["grading_period_id"] = $grading_period_id}

	if ($order) {$Body["order"] = $order}

	if ($order_direction) {$Body["order_direction"] = $order_direction}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get a single submission 
.DESCRIPTION
   Get a single submission, based on user id.
.EXAMPLE
   PS C:> Get-CanvasCoursesAssignmentsSubmissions -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -UserId $SomeUserIdObj -Include $SomeIncludeObj
#>
function Get-CanvasCoursesAssignmentsSubmissions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # Associations to include with the group.
		#Allowed values: submission_history, submission_comments, rubric_assessment, visibility, course, user 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/submissions/{2}" -f $CourseId, $AssignmentId, $UserId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Upload a file 
.DESCRIPTION
   Upload a file to a submission. This API endpoint is the first step in uploading a file to a submission as a student. See the File Upload Documentation for details on the file upload workflow. The final step of the file upload workflow will return the attachment data, including the new file id. The caller can then POST to submit the online_upload assignment with these file ids.
.EXAMPLE
   PS C:> Post-CanvasCoursesAssignmentsSubmissionsFiles -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -UserId $SomeUserIdObj
#>
function Post-CanvasCoursesAssignmentsSubmissionsFiles {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/submissions/{2}/files" -f $CourseId, $AssignmentId, $UserId 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   Grade or comment on a submission 
.DESCRIPTION
   Comment on and/or update the grading for a student's assignment submission. If any submission or rubric_assessment arguments are provided, the user must have permission to manage grades in the appropriate context (course or section).
.EXAMPLE
   PS C:> Put-CanvasCoursesAssignmentsSubmissions -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -UserId $SomeUserIdObj -TextComment $SomeTextCommentObj -GroupComment $SomeGroupCommentObj -MediaCommentId $SomeMediaCommentIdObj -MediaCommentType $SomeMediaCommentTypeObj -Comment[FileIds] $SomeComment[FileIds]Obj -Visibility $SomeVisibilityObj -PostedGrade $SomePostedGradeObj -Excuse $SomeExcuseObj -rubric_assessment $Somerubric_assessmentObj
#><#
function Put-CanvasCoursesAssignmentsSubmissions {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # Add a textual comment to the submission.
        [Parameter(Mandatory=$false)]
        $TextComment,

        # Whether or not this comment should be sent to the entire group (defaults to false). Ignored if this is not a group assignment or if no text_comment is provided.
        [Parameter(Mandatory=$false)]
        $GroupComment,

        # Add an audio/video comment to the submission. Media comments can be added via this API, however, note that there is not yet an API to generate or list existing media comments, so this functionality is currently of limited use.
        [Parameter(Mandatory=$false)]
        $MediaCommentId,

        # The type of media comment being added.
		#Allowed values: audio, video 
        [Parameter(Mandatory=$false)]
        $MediaCommentType,

        # Attach files to this comment that were previously uploaded using the Submission Comment API's files action
        [Parameter(Mandatory=$false)]
        $Comment[FileIds],

        # Whether this assignment is visible to the owner of the submission
        [Parameter(Mandatory=$false)]
        $Visibility,

        # Assign a score to the submission, updating both the âscoreâ and âgradeâ fields on the submission record. This parameter can be passed in a few different formats:
		#points 
		#A floating point or integral value, such as â13.5â. The grade
		#will be interpreted directly as the score of the assignment.
		#Values above assignment.points_possible are allowed, for awarding
		#extra credit.percentage 
		#A floating point value appended with a percent sign, such as
		#"40%". The grade will be interpreted as a percentage score on the
		#assignment, where 100% == assignment.points_possible. Values above 100%
		#are allowed, for awarding extra credit.letter grade 
		#A letter grade, following the assignment's defined letter
		#grading scheme. For example, "A-". The resulting score will be the high
		#end of the defined range for the letter grade. For instance, if "B" is
		#defined as 86% to 84%, a letter grade of "B" will be worth 86%. The
		#letter grade will be rejected if the assignment does not have a defined
		#letter grading scheme. For more fine-grained control of scores, pass in
		#points or percentage rather than the letter grade.âpass/complete/fail/incompleteâ 
		#A string value of âpassâ or âcompleteâ
		#will give a score of 100%. "fail" or "incomplete" will give a score of
		#0.Note that assignments with grading_type of âpass_failâ can only be assigned a score of 0 or assignment.points_possible, nothing inbetween. If a posted_grade in the âpointsâ or âpercentageâ format is sent, the grade will only be accepted if the grade equals one of those two values.
        [Parameter(Mandatory=$false)]
        $PostedGrade,

        # Sets the âexcusedâ status of an assignment.
        [Parameter(Mandatory=$false)]
        $Excuse,

        # Assign a rubric assessment to this assignment submission. The sub-parameters here depend on the rubric for the assignment. The general format is, for each row in the rubric:
		#The points awarded for this row.
		#rubric_assessment[criterion_id][points]
		#Comments to add for this row.
		#rubric_assessment[criterion_id][comments]
		#For example, if the assignment rubric is (in JSON format):
		#[
		#  {
		#    'id': 'crit1',
		#    'points': 10,
		#    'description': 'Criterion 1',
		#    'ratings':
		#    [
		#      { 'description': 'Good', 'points': 10 },
		#      { 'description': 'Poor', 'points': 3 }
		#    ]
		#  },
		#  {
		#    'id': 'crit2',
		#    'points': 5,
		#    'description': 'Criterion 2',
		#    'ratings':
		#    [
		#      { 'description': 'Complete', 'points': 5 },
		#      { 'description': 'Incomplete', 'points': 0 }
		#    ]
		#  }
		#]
		#Then a possible set of values for rubric_assessment would be:
		#rubric_assessment[crit1][points]=3&rubric_assessment[crit2][points]=5&rubric_assessment[crit2][comments]=Well%20Done.
        [Parameter(Mandatory=$false)]
        $rubric_assessment
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/submissions/{2}" -f $CourseId, $AssignmentId, $UserId 

	$Body = @{}

	if ($TextComment) {$Body["comment[text_comment]"] = $TextComment}

	if ($GroupComment) {$Body["comment[group_comment]"] = $GroupComment}

	if ($MediaCommentId) {$Body["comment[media_comment_id]"] = $MediaCommentId}

	if ($MediaCommentType) {$Body["comment[media_comment_type]"] = $MediaCommentType}

	if ($Comment[FileIds]) {$Body["comment[file_ids][]"] = $Comment[FileIds]}

	if ($Visibility) {$Body["include[visibility]"] = $Visibility}

	if ($PostedGrade) {$Body["submission[posted_grade]"] = $PostedGrade}

	if ($Excuse) {$Body["submission[excuse]"] = $Excuse}

	if ($rubric_assessment) {$Body["rubric_assessment"] = $rubric_assessment}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}
#>

<#
.Synopsis
   List gradeable students 
.DESCRIPTION
   List students eligible to submit the assignment. The caller must have permission to view grades. Section-limited instructors will only see students in their own sections. returns [UserDisplay]
.EXAMPLE
   PS C:> Get-CanvasCoursesAssignmentsGradeableStudents -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj
#>
function Get-CanvasCoursesAssignmentsGradeableStudents {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/gradeable_students" -f $CourseId, $AssignmentId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Grade or comment on multiple submissions 
.DESCRIPTION
   Update the grading and comments on multiple student's assignment submissions in an asynchronous job. The user must have permission to manage grades in the appropriate context (course or section).
.EXAMPLE
   PS C:> Post-CanvasCoursesSubmissionsUpdateGrades -CourseId $SomeCourseIdObj -PostedGrade $SomePostedGradeObj -Excuse $SomeExcuseObj -RubricAssessment $SomeRubricAssessmentObj -TextComment $SomeTextCommentObj -GroupComment $SomeGroupCommentObj -MediaCommentId $SomeMediaCommentIdObj -MediaCommentType $SomeMediaCommentTypeObj -GradeData[<StudentId>][FileIds] $SomeGradeData[<StudentId>][FileIds]Obj
#><#
function Post-CanvasCoursesSubmissionsUpdateGrades {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # See documentation for the posted_grade argument in the Submissions Update documentation
        [Parameter(Mandatory=$false)]
        $PostedGrade,

        # See documentation for the excuse argument in the Submissions Update documentation
        [Parameter(Mandatory=$false)]
        $Excuse,

        # See documentation for the rubric_assessment argument in the Submissions Update documentation
        [Parameter(Mandatory=$false)]
        $RubricAssessment,

        # no description
        [Parameter(Mandatory=$false)]
        $TextComment,

        # no description
        [Parameter(Mandatory=$false)]
        $GroupComment,

        # no description
        [Parameter(Mandatory=$false)]
        $MediaCommentId,

        # no description
		#Allowed values: audio, video 
        [Parameter(Mandatory=$false)]
        $MediaCommentType,

        # See documentation for the comment[] arguments in the Submissions Update documentation
        [Parameter(Mandatory=$false)]
        $GradeData[<StudentId>][FileIds]
	)

    $uri = "/api/v1/courses/{0}/submissions/update_grades" -f $CourseId 

	$Body = @{}

	if ($PostedGrade) {$Body["grade_data[<student_id>][posted_grade]"] = $PostedGrade}

	if ($Excuse) {$Body["grade_data[<student_id>][excuse]"] = $Excuse}

	if ($RubricAssessment) {$Body["grade_data[<student_id>][rubric_assessment]"] = $RubricAssessment}

	if ($TextComment) {$Body["grade_data[<student_id>][text_comment]"] = $TextComment}

	if ($GroupComment) {$Body["grade_data[<student_id>][group_comment]"] = $GroupComment}

	if ($MediaCommentId) {$Body["grade_data[<student_id>][media_comment_id]"] = $MediaCommentId}

	if ($MediaCommentType) {$Body["grade_data[<student_id>][media_comment_type]"] = $MediaCommentType}

	if ($GradeData[<StudentId>][FileIds]) {$Body["grade_data[<student_id>][file_ids][]"] = $GradeData[<StudentId>][FileIds]}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}
#>

<#
.Synopsis
   Mark submission as read 
.DESCRIPTION
   No request fields are necessary. On success, the response will be 204 No Content with an empty body.
.EXAMPLE
   PS C:> Put-CanvasCoursesAssignmentsSubmissionsRead -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -UserId $SomeUserIdObj
#>
function Put-CanvasCoursesAssignmentsSubmissionsRead {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/submissions/{2}/read" -f $CourseId, $AssignmentId, $UserId 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Mark submission as unread 
.DESCRIPTION
   No request fields are necessary. On success, the response will be 204 No Content with an empty body.
.EXAMPLE
   PS C:> Delete-CanvasCoursesAssignmentsSubmissionsRead -CourseId $SomeCourseIdObj -AssignmentId $SomeAssignmentIdObj -UserId $SomeUserIdObj
#>
function Delete-CanvasCoursesAssignmentsSubmissionsRead {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The AssignmentId
        [Parameter(Mandatory=$true)]
        $AssignmentId,

        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId
	)

    $uri = "/api/v1/courses/{0}/assignments/{1}/submissions/{2}/read" -f $CourseId, $AssignmentId, $UserId 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   List available tabs for a course or group 
.DESCRIPTION
   Returns a list of navigation tabs available in the current context.
.EXAMPLE
   PS C:> Get-CanvasCoursesTabs -CourseId $SomeCourseIdObj -Include $SomeIncludeObj
#>
function Get-CanvasCoursesTabs {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # âexternalâ 
		#Optionally include external tool tabs in the returned list of tabs (Only has effect for courses, not groups)
		#Allowed values: external 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/courses/{0}/tabs" -f $CourseId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Update a tab for a course 
.DESCRIPTION
   Home and Settings tabs are not manageable, and can't be hidden or moved Returns a tab object
.EXAMPLE
   PS C:> Put-CanvasCoursesTabs -CourseId $SomeCourseIdObj -TabId $SomeTabIdObj -position $SomepositionObj -hidden $SomehiddenObj
#>
function Put-CanvasCoursesTabs {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The TabId
        [Parameter(Mandatory=$true)]
        $TabId,

        # The new position of the tab, 1-based
        [Parameter(Mandatory=$false)]
        $position,

        # no description
        [Parameter(Mandatory=$false)]
        $hidden
	)

    $uri = "/api/v1/courses/{0}/tabs/{1}" -f $CourseId, $TabId 

	$Body = @{}

	if ($position) {$Body["position"] = $position}

	if ($hidden) {$Body["hidden"] = $hidden}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   List observees 
.DESCRIPTION
   List the users that the given user is observing. Note: all users are allowed to list their own observees. Administrators can list other users' observees.
.EXAMPLE
   PS C:> Get-CanvasUsersObservees -UserId $SomeUserIdObj -Include $SomeIncludeObj
#>
function Get-CanvasUsersObservees {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # âavatar_urlâ: Optionally include avatar_url.
		#Allowed values: avatar_url 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/users/{0}/observees" -f $UserId 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Add an observee with credentials 
.DESCRIPTION
   Register the given user to observe another user, given the observee's credentials. Note: all users are allowed to add their own observees, given the observee's credentials or access token are provided. Administrators can add observees given credentials, access token or the observee's id.
.EXAMPLE
   PS C:> Post-CanvasUsersObservees -UserId $SomeUserIdObj -UniqueId $SomeUniqueIdObj -Password $SomePasswordObj -access_token $Someaccess_tokenObj
#>
function Post-CanvasUsersObservees {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The login id for the user to observe. Required if access_token is omitted.
        [Parameter(Mandatory=$false)]
        $UniqueId,

        # The password for the user to observe. Required if access_token is omitted.
        [Parameter(Mandatory=$false)]
        $Password,

        # The access token for the user to observe. Required if observee[unique_id] or observee[password] are omitted.
        [Parameter(Mandatory=$false)]
        $access_token
	)

    $uri = "/api/v1/users/{0}/observees" -f $UserId 

	$Body = @{}

	if ($UniqueId) {$Body["observee[unique_id]"] = $UniqueId}

	if ($Password) {$Body["observee[password]"] = $Password}

	if ($access_token) {$Body["access_token"] = $access_token}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Show an observee 
.DESCRIPTION
   Gets information about an observed user. Note: all users are allowed to view their own observees.
.EXAMPLE
   PS C:> Get-CanvasUsersObservees -UserId $SomeUserIdObj -ObserveeId $SomeObserveeIdObj
#>
function Get-CanvasUsersObservees {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The ObserveeId
        [Parameter(Mandatory=$true)]
        $ObserveeId
	)

    $uri = "/api/v1/users/{0}/observees/{1}" -f $UserId, $ObserveeId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Add an observee 
.DESCRIPTION
   Registers a user as being observed by the given user.
.EXAMPLE
   PS C:> Put-CanvasUsersObservees -UserId $SomeUserIdObj -ObserveeId $SomeObserveeIdObj
#>
function Put-CanvasUsersObservees {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The ObserveeId
        [Parameter(Mandatory=$true)]
        $ObserveeId
	)

    $uri = "/api/v1/users/{0}/observees/{1}" -f $UserId, $ObserveeId 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Remove an observee 
.DESCRIPTION
   Unregisters a user as being observed by the given user.
.EXAMPLE
   PS C:> Delete-CanvasUsersObservees -UserId $SomeUserIdObj -ObserveeId $SomeObserveeIdObj
#>
function Delete-CanvasUsersObservees {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The ObserveeId
        [Parameter(Mandatory=$true)]
        $ObserveeId
	)

    $uri = "/api/v1/users/{0}/observees/{1}" -f $UserId, $ObserveeId 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   List users in account 
.DESCRIPTION
   Retrieve the list of users associated with this account.
.EXAMPLE
   PS C:> Get-CanvasAccountsUsers -AccountId $SomeAccountIdObj -search_term $Somesearch_termObj
#>
function Get-CanvasAccountsUsers {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The partial name or full ID of the users to match and return in the results list. Must be at least 3 characters.
		#Note that the API will prefer matching on canonical user ID if the ID has a numeric form. It will only search against other fields if non-numeric in form, or if the numeric value doesn't yield any matches. Queries by administrative users will search on SIS ID, name, or email address; non- administrative queries will only be compared against name.
        [Parameter(Mandatory=$false)]
        $search_term
	)

    $uri = "/api/v1/accounts/{0}/users" -f $AccountId 

	$Body = @{}

	if ($search_term) {$Body["search_term"] = $search_term}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List the activity stream 
.DESCRIPTION
   Returns the current user's global activity stream, paginated. There are many types of objects that can be returned in the activity stream. All object types have the same basic set of shared attributes: In addition, each item type has its own set of attributes available. DiscussionTopic: For DiscussionTopic, the message is truncated at 4kb. Announcement: For Announcement, the message is truncated at 4kb. Conversation: Message: Submission: Returns an Submission with its Course and Assignment data. Conference: Collaboration: AssessmentRequest:
.EXAMPLE
   PS C:> Get-CanvasUsersSelfActivityStream
#>
function Get-CanvasUsersSelfActivityStream {
[CmdletBinding()]

    $uri = "/api/v1/users/self/activity_stream" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Activity stream summary 
.DESCRIPTION
   Returns a summary of the current user's global activity stream.
.EXAMPLE
   PS C:> Get-CanvasUsersSelfActivityStreamSummary
#>
function Get-CanvasUsersSelfActivityStreamSummary {
[CmdletBinding()]

    $uri = "/api/v1/users/self/activity_stream/summary" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List the TODO items 
.DESCRIPTION
   Returns the current user's list of todo items, as seen on the user dashboard. There is a limit to the number of items returned. The `ignore` and `ignore_permanently` URLs can be used to update the user's preferences on what items will be displayed. Performing a DELETE request against the `ignore` URL will hide that item from future todo item requests, until the item changes. Performing a DELETE request against the `ignore_permanently` URL will hide that item forever.
.EXAMPLE
   PS C:> Get-CanvasUsersSelfTodo -Include $SomeIncludeObj
#>
function Get-CanvasUsersSelfTodo {
[CmdletBinding()]

	Param
	(
        # âungraded_quizzesâ 
		#Optionally include ungraded quizzes (such as practice quizzes and surveys) in the list. These will be returned under a quiz key instead of an assignment key in response elements.
		#Allowed values: ungraded_quizzes 
        [Parameter(Mandatory=$false)]
        $Include
	)

    $uri = "/api/v1/users/self/todo" 

	$Body = @{}

	if ($Include) {$Body["include[]"] = $Include}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   List upcoming assignments, calendar events 
.DESCRIPTION
   Returns the current user's upcoming events, i.e. the same things shown in the dashboard 'Coming Up' sidebar.
.EXAMPLE
   PS C:> Get-CanvasUsersSelfUpcomingEvents
#>
function Get-CanvasUsersSelfUpcomingEvents {
[CmdletBinding()]

    $uri = "/api/v1/users/self/upcoming_events" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List Missing Submissions 
.DESCRIPTION
   returns past-due assignments for which the student does not have a submission. The user sending the request must either be an admin or a parent observer using the parent app
.EXAMPLE
   PS C:> Get-CanvasUsersMissingSubmissions -UserId $SomeUserIdObj -user_id $Someuser_idObj
#>
function Get-CanvasUsersMissingSubmissions {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # the student's ID
        [Parameter(Mandatory=$false)]
        $user_id
	)

    $uri = "/api/v1/users/{0}/missing_submissions" -f $UserId 

	$Body = @{}

	if ($user_id) {$Body["user_id"] = $user_id}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Hide a stream item 
.DESCRIPTION
   Hide the given stream item.
.EXAMPLE
   PS C:> Delete-CanvasUsersSelfActivityStream -Id $SomeIdObj
#>
function Delete-CanvasUsersSelfActivityStream {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/users/self/activity_stream/{0}" -f $Id 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Hide all stream items 
.DESCRIPTION
   Hide all stream items for the user
.EXAMPLE
   PS C:> Delete-CanvasUsersSelfActivityStream
#>
function Delete-CanvasUsersSelfActivityStream {
[CmdletBinding()]

    $uri = "/api/v1/users/self/activity_stream" 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Upload a file 
.DESCRIPTION
   Upload a file to the user's personal files section. This API endpoint is the first step in uploading a file to a user's files. See the File Upload Documentation for details on the file upload workflow. Note that typically users will only be able to upload files to their own files section. Passing a user_id of self is an easy shortcut to specify the current user.
.EXAMPLE
   PS C:> Post-CanvasUsersFiles -UserId $SomeUserIdObj
#>
function Post-CanvasUsersFiles {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId
	)

    $uri = "/api/v1/users/{0}/files" -f $UserId 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   Show user details 
.DESCRIPTION
   Shows details for user. Also includes an attribute âpermissionsâ, a non-comprehensive list of permissions for the user. Example:
.EXAMPLE
   PS C:> Get-CanvasUsers -Id $SomeIdObj
#>
function Get-CanvasUsers {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/users/{0}" -f $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create a user 
.DESCRIPTION
   Create and return a new user and pseudonym for an account. If you don't have the âModify login details for usersâ permission, but self-registration is enabled on the account, you can still use this endpoint to register new users. Certain fields will be required, and others will be ignored (see below).
.EXAMPLE
   PS C:> Post-CanvasAccountsUsers -AccountId $SomeAccountIdObj -Name $SomeNameObj -ShortName $SomeShortNameObj -SortableName $SomeSortableNameObj -TimeZone $SomeTimeZoneObj -Locale $SomeLocaleObj -Birthdate $SomeBirthdateObj -TermsOfUse $SomeTermsOfUseObj -SkipRegistration $SomeSkipRegistrationObj -UniqueId $SomeUniqueIdObj -Password $SomePasswordObj -SisUserId $SomeSisUserIdObj -IntegrationId $SomeIntegrationIdObj -SendConfirmation $SomeSendConfirmationObj -ForceSelfRegistration $SomeForceSelfRegistrationObj -AuthenticationProviderId $SomeAuthenticationProviderIdObj -Type $SomeTypeObj -Address $SomeAddressObj -ConfirmationUrl $SomeConfirmationUrlObj -SkipConfirmation $SomeSkipConfirmationObj -force_validations $Someforce_validationsObj -enable_sis_reactivation $Someenable_sis_reactivationObj
#>
function Post-CanvasAccountsUsers {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The full name of the user. This name will be used by teacher for grading. Required if this is a self-registration.
        [Parameter(Mandatory=$false)]
        $Name,

        # User's name as it will be displayed in discussions, messages, and comments.
        [Parameter(Mandatory=$false)]
        $ShortName,

        # User's name as used to sort alphabetically in lists.
        [Parameter(Mandatory=$false)]
        $SortableName,

        # The time zone for the user. Allowed time zones are IANA time zones or friendlier Ruby on Rails time zones.
        [Parameter(Mandatory=$false)]
        $TimeZone,

        # The user's preferred language, from the list of languages Canvas supports. This is in RFC-5646 format.
        [Parameter(Mandatory=$false)]
        $Locale,

        # The user's birth date.
        [Parameter(Mandatory=$false)]
        $Birthdate,

        # Whether the user accepts the terms of use. Required if this is a self-registration and this canvas instance requires users to accept the terms (on by default).
		#If this is true, it will mark the user as having accepted the terms of use.
        [Parameter(Mandatory=$false)]
        $TermsOfUse,

        # Automatically mark the user as registered.
		#If this is true, it is recommended to set "pseudonym[send_confirmation]" to true as well. Otherwise, the user will not receive any messages about their account creation.
		#The users communication channel confirmation can be skipped by setting "communication_channel[skip_confirmation]" to true as well.
        [Parameter(Mandatory=$false)]
        $SkipRegistration,

        # User's login ID. If this is a self-registration, it must be a valid email address.
        [Parameter(Mandatory=$true)]
        $UniqueId,

        # User's password. Cannot be set during self-registration.
        [Parameter(Mandatory=$false)]
        $Password,

        # SIS ID for the user's account. To set this parameter, the caller must be able to manage SIS permissions.
        [Parameter(Mandatory=$false)]
        $SisUserId,

        # Integration ID for the login. To set this parameter, the caller must be able to manage SIS permissions. The Integration ID is a secondary identifier useful for more complex SIS integrations.
        [Parameter(Mandatory=$false)]
        $IntegrationId,

        # Send user notification of account creation if true. Automatically set to true during self-registration.
        [Parameter(Mandatory=$false)]
        $SendConfirmation,

        # Send user a self-registration style email if true. Setting it means the users will get a notification asking them to âcomplete the registration processâ by clicking it, setting a password, and letting them in. Will only be executed on if the user does not need admin approval. Defaults to false unless explicitly provided.
        [Parameter(Mandatory=$false)]
        $ForceSelfRegistration,

        # The authentication provider this login is associated with. Logins associated with a specific provider can only be used with that provider. Legacy providers (LDAP, CAS, SAML) will search for logins associated with them, or unassociated logins. New providers will only search for logins explicitly associated with them. This can be the integer ID of the provider, or the type of the provider (in which case, it will find the first matching provider).
        [Parameter(Mandatory=$false)]
        $AuthenticationProviderId,

        # The communication channel type, e.g. 'email' or 'sms'.
        [Parameter(Mandatory=$false)]
        $Type,

        # The communication channel address, e.g. the user's email address.
        [Parameter(Mandatory=$false)]
        $Address,

        # Only valid for account admins. If true, returns the new user account confirmation URL in the response.
        [Parameter(Mandatory=$false)]
        $ConfirmationUrl,

        # Only valid for site admins and account admins making requests; If true, the channel is automatically validated and no confirmation email or SMS is sent. Otherwise, the user must respond to a confirmation message to confirm the channel.
		#If this is true, it is recommended to set "pseudonym[send_confirmation]" to true as well. Otherwise, the user will not receive any messages about their account creation.
        [Parameter(Mandatory=$false)]
        $SkipConfirmation,

        # If true, validations are performed on the newly created user (and their associated pseudonym) even if the request is made by a privileged user like an admin. When set to false, or not included in the request parameters, any newly created users are subject to validations unless the request is made by a user with a 'manage_user_logins' right. In which case, certain validations such as 'require_acceptance_of_terms' and 'require_presence_of_name' are not enforced. Use this parameter to return helpful json errors while building users with an admin request.
        [Parameter(Mandatory=$false)]
        $force_validations,

        # When true, will first try to re-activate a deleted user with matching sis_user_id if possible.
        [Parameter(Mandatory=$false)]
        $enable_sis_reactivation
	)

    $uri = "/api/v1/accounts/{0}/users" -f $AccountId 

	$Body = @{}

	if ($Name) {$Body["user[name]"] = $Name}

	if ($ShortName) {$Body["user[short_name]"] = $ShortName}

	if ($SortableName) {$Body["user[sortable_name]"] = $SortableName}

	if ($TimeZone) {$Body["user[time_zone]"] = $TimeZone}

	if ($Locale) {$Body["user[locale]"] = $Locale}

	if ($Birthdate) {$Body["user[birthdate]"] = $Birthdate}

	if ($TermsOfUse) {$Body["user[terms_of_use]"] = $TermsOfUse}

	if ($SkipRegistration) {$Body["user[skip_registration]"] = $SkipRegistration}

	$Body["pseudonym[unique_id]"] = $UniqueId

	if ($Password) {$Body["pseudonym[password]"] = $Password}

	if ($SisUserId) {$Body["pseudonym[sis_user_id]"] = $SisUserId}

	if ($IntegrationId) {$Body["pseudonym[integration_id]"] = $IntegrationId}

	if ($SendConfirmation) {$Body["pseudonym[send_confirmation]"] = $SendConfirmation}

	if ($ForceSelfRegistration) {$Body["pseudonym[force_self_registration]"] = $ForceSelfRegistration}

	if ($AuthenticationProviderId) {$Body["pseudonym[authentication_provider_id]"] = $AuthenticationProviderId}

	if ($Type) {$Body["communication_channel[type]"] = $Type}

	if ($Address) {$Body["communication_channel[address]"] = $Address}

	if ($ConfirmationUrl) {$Body["communication_channel[confirmation_url]"] = $ConfirmationUrl}

	if ($SkipConfirmation) {$Body["communication_channel[skip_confirmation]"] = $SkipConfirmation}

	if ($force_validations) {$Body["force_validations"] = $force_validations}

	if ($enable_sis_reactivation) {$Body["enable_sis_reactivation"] = $enable_sis_reactivation}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Self register a user 
.DESCRIPTION
   Self register and return a new user and pseudonym for an account. If self-registration is enabled on the account, you can use this endpoint to self register new users.
.EXAMPLE
   PS C:> Post-CanvasAccountsSelfRegistration -AccountId $SomeAccountIdObj -Name $SomeNameObj -ShortName $SomeShortNameObj -SortableName $SomeSortableNameObj -TimeZone $SomeTimeZoneObj -Locale $SomeLocaleObj -Birthdate $SomeBirthdateObj -TermsOfUse $SomeTermsOfUseObj -UniqueId $SomeUniqueIdObj -Type $SomeTypeObj -Address $SomeAddressObj
#>
function Post-CanvasAccountsSelfRegistration {
[CmdletBinding()]

	Param
	(
        # The AccountId
        [Parameter(Mandatory=$true)]
        $AccountId,

        # The full name of the user. This name will be used by teacher for grading.
        [Parameter(Mandatory=$true)]
        $Name,

        # User's name as it will be displayed in discussions, messages, and comments.
        [Parameter(Mandatory=$false)]
        $ShortName,

        # User's name as used to sort alphabetically in lists.
        [Parameter(Mandatory=$false)]
        $SortableName,

        # The time zone for the user. Allowed time zones are IANA time zones or friendlier Ruby on Rails time zones.
        [Parameter(Mandatory=$false)]
        $TimeZone,

        # The user's preferred language, from the list of languages Canvas supports. This is in RFC-5646 format.
        [Parameter(Mandatory=$false)]
        $Locale,

        # The user's birth date.
        [Parameter(Mandatory=$false)]
        $Birthdate,

        # Whether the user accepts the terms of use.
        [Parameter(Mandatory=$true)]
        $TermsOfUse,

        # User's login ID. Must be a valid email address.
        [Parameter(Mandatory=$true)]
        $UniqueId,

        # The communication channel type, e.g. 'email' or 'sms'.
        [Parameter(Mandatory=$false)]
        $Type,

        # The communication channel address, e.g. the user's email address.
        [Parameter(Mandatory=$false)]
        $Address
	)

    $uri = "/api/v1/accounts/{0}/self_registration" -f $AccountId 

	$Body = @{}

	$Body["user[name]"] = $Name

	if ($ShortName) {$Body["user[short_name]"] = $ShortName}

	if ($SortableName) {$Body["user[sortable_name]"] = $SortableName}

	if ($TimeZone) {$Body["user[time_zone]"] = $TimeZone}

	if ($Locale) {$Body["user[locale]"] = $Locale}

	if ($Birthdate) {$Body["user[birthdate]"] = $Birthdate}

	$Body["user[terms_of_use]"] = $TermsOfUse

	$Body["pseudonym[unique_id]"] = $UniqueId

	if ($Type) {$Body["communication_channel[type]"] = $Type}

	if ($Address) {$Body["communication_channel[address]"] = $Address}

    return Get-CanvasApiResult $uri -Method POST -RequestParameters $Body
}


<#
.Synopsis
   Update user settings. 
.DESCRIPTION
   Update an existing user's settings.
.EXAMPLE
   PS C:> Get-CanvasUsersSettings -Id $SomeIdObj -manual_mark_as_read $Somemanual_mark_as_readObj -collapse_global_nav $Somecollapse_global_navObj
#>
function Get-CanvasUsersSettings {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # If true, require user to manually mark discussion posts as read (don't auto-mark as read).
        [Parameter(Mandatory=$false)]
        $manual_mark_as_read,

        # If true, the user's page loads with the global navigation collapsed
        [Parameter(Mandatory=$false)]
        $collapse_global_nav
	)

    $uri = "/api/v1/users/{0}/settings" -f $Id 

	$Body = @{}

	if ($manual_mark_as_read) {$Body["manual_mark_as_read"] = $manual_mark_as_read}

	if ($collapse_global_nav) {$Body["collapse_global_nav"] = $collapse_global_nav}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Get custom colors 
.DESCRIPTION
   Returns all custom colors that have been saved for a user.
.EXAMPLE
   PS C:> Get-CanvasUsersColors -Id $SomeIdObj
#>
function Get-CanvasUsersColors {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/users/{0}/colors" -f $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get custom color 
.DESCRIPTION
   Returns the custom colors that have been saved for a user for a given context. The asset_string parameter should be in the format 'context_id', for example 'course_42'.
.EXAMPLE
   PS C:> Get-CanvasUsersColors -Id $SomeIdObj -AssetString $SomeAssetStringObj
#>
function Get-CanvasUsersColors {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The AssetString
        [Parameter(Mandatory=$true)]
        $AssetString
	)

    $uri = "/api/v1/users/{0}/colors/{1}" -f $Id, $AssetString 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Update custom color 
.DESCRIPTION
   Updates a custom color for a user for a given context. This allows colors for the calendar and elsewhere to be customized on a user basis. The asset string parameter should be in the format 'context_id', for example 'course_42'
.EXAMPLE
   PS C:> Put-CanvasUsersColors -Id $SomeIdObj -AssetString $SomeAssetStringObj -hexcode $SomehexcodeObj
#>
function Put-CanvasUsersColors {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The AssetString
        [Parameter(Mandatory=$true)]
        $AssetString,

        # The hexcode of the color to set for the context, if you choose to pass the hexcode as a query parameter rather than in the request body you should NOT include the '#' unless you escape it first.
        [Parameter(Mandatory=$false)]
        $hexcode
	)

    $uri = "/api/v1/users/{0}/colors/{1}" -f $Id, $AssetString 

	$Body = @{}

	if ($hexcode) {$Body["hexcode"] = $hexcode}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Get dashboard postions 
.DESCRIPTION
   Returns all dashboard positions that have been saved for a user.
.EXAMPLE
   PS C:> Get-CanvasUsersDashboardPositions -Id $SomeIdObj
#>
function Get-CanvasUsersDashboardPositions {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/users/{0}/dashboard_positions" -f $Id 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Update dashboard positions 
.DESCRIPTION
   Updates the dashboard positions for a user for a given context. This allows positions for the dashboard cards and elsewhere to be customized on a per user basis. The asset string parameter should be in the format 'context_id', for example 'course_42'
.EXAMPLE
   PS C:> Put-CanvasUsersDashboardPositions -Id $SomeIdObj
#>
function Put-CanvasUsersDashboardPositions {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/users/{0}/dashboard_positions" -f $Id 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Edit a user 
.DESCRIPTION
   Modify an existing user. To modify a user's login, see the documentation for logins.
.EXAMPLE
   PS C:> Put-CanvasUsers -Id $SomeIdObj -Name $SomeNameObj -ShortName $SomeShortNameObj -SortableName $SomeSortableNameObj -TimeZone $SomeTimeZoneObj -Email $SomeEmailObj -Locale $SomeLocaleObj -Token $SomeTokenObj -Url $SomeUrlObj
#>
function Put-CanvasUsers {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The full name of the user. This name will be used by teacher for grading.
        [Parameter(Mandatory=$false)]
        $Name,

        # User's name as it will be displayed in discussions, messages, and comments.
        [Parameter(Mandatory=$false)]
        $ShortName,

        # User's name as used to sort alphabetically in lists.
        [Parameter(Mandatory=$false)]
        $SortableName,

        # The time zone for the user. Allowed time zones are IANA time zones or friendlier Ruby on Rails time zones.
        [Parameter(Mandatory=$false)]
        $TimeZone,

        # The default email address of the user.
        [Parameter(Mandatory=$false)]
        $Email,

        # The user's preferred language, from the list of languages Canvas supports. This is in RFC-5646 format.
        [Parameter(Mandatory=$false)]
        $Locale,

        # A unique representation of the avatar record to assign as the user's current avatar. This token can be obtained from the user avatars endpoint. This supersedes the user [avatar] [url] argument, and if both are included the url will be ignored. Note: this is an internal representation and is subject to change without notice. It should be consumed with this api endpoint and used in the user update endpoint, and should not be constructed by the client.
        [Parameter(Mandatory=$false)]
        $Token,

        # To set the user's avatar to point to an external url, do not include a token and instead pass the url here. Warning: For maximum compatibility, please use 128 px square images.
        [Parameter(Mandatory=$false)]
        $Url
	)

    $uri = "/api/v1/users/{0}" -f $Id 

	$Body = @{}

	if ($Name) {$Body["user[name]"] = $Name}

	if ($ShortName) {$Body["user[short_name]"] = $ShortName}

	if ($SortableName) {$Body["user[sortable_name]"] = $SortableName}

	if ($TimeZone) {$Body["user[time_zone]"] = $TimeZone}

	if ($Email) {$Body["user[email]"] = $Email}

	if ($Locale) {$Body["user[locale]"] = $Locale}

	if ($Token) {$Body["user[avatar][token]"] = $Token}

	if ($Url) {$Body["user[avatar][url]"] = $Url}

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Merge user into another user 
.DESCRIPTION
   Merge a user into another user. To merge users, the caller must have permissions to manage both users. This should be considered irreversible. This will delete the user and move all the data into the destination user. When finding users by SIS ids in different accounts the destination_account_id is required. The account can also be identified by passing the domain in destination_account_id.
.EXAMPLE
   PS C:> Put-CanvasUsersMergeInto -Id $SomeIdObj -DestinationUserId $SomeDestinationUserIdObj
#>
function Put-CanvasUsersMergeInto {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id,

        # The DestinationUserId
        [Parameter(Mandatory=$true)]
        $DestinationUserId
	)

    $uri = "/api/v1/users/{0}/merge_into/{1}" -f $Id, $DestinationUserId 

    return Get-CanvasApiResult $uri -Method PUT
}


<#
.Synopsis
   Split merged users into separate users 
.DESCRIPTION
   Merged users cannot be fully restored to their previous state, but this will attempt to split as much as possible to the previous state. To split a merged user, the caller must have permissions to manage all of the users logins. If there are multiple users that have been merged into one user it will split each merge into a separate user. A split can only happen within 90 days of a user merge. A user merge deletes the previous user and may be permanently deleted. In this scenario we create a new user object and proceed to move as much as possible to the new user. The user object will not have preserved the name or settings from the previous user. Some items may have been deleted during a user_merge that cannot be restored, and/or the data has become stale because of other changes to the objects since the time of the user_merge.
.EXAMPLE
   PS C:> Post-CanvasUsersSplit -Id $SomeIdObj
#>
function Post-CanvasUsersSplit {
[CmdletBinding()]

	Param
	(
        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/users/{0}/split" -f $Id 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   Get user profile 
.DESCRIPTION
   Returns user profile data, including user id, name, and profile pic. When requesting the profile for the user accessing the API, the user's calendar feed URL will be returned as well.
.EXAMPLE
   PS C:> Get-CanvasUsersProfile -UserId $SomeUserIdObj
#>
function Get-CanvasUsersProfile {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId
	)

    $uri = "/api/v1/users/{0}/profile" -f $UserId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List avatar options 
.DESCRIPTION
   Retrieve the possible user avatar options that can be set with the user update endpoint. The response will be an array of avatar records. If the 'type' field is 'attachment', the record will include all the normal attachment json fields; otherwise it will include only the 'url' and 'display_name' fields. Additionally, all records will include a 'type' field and a 'token' field. The following explains each field in more detail
.EXAMPLE
   PS C:> Get-CanvasUsersAvatars -UserId $SomeUserIdObj
#>
function Get-CanvasUsersAvatars {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId
	)

    $uri = "/api/v1/users/{0}/avatars" -f $UserId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   List user page views 
.DESCRIPTION
   Return the user's page view history in json format, similar to the available CSV download. Pagination is used as described in API basics section. Page views are returned in descending order, newest to oldest.
.EXAMPLE
   PS C:> Get-CanvasUsersPageViews -UserId $SomeUserIdObj -start_time $Somestart_timeObj -end_time $Someend_timeObj
#>
function Get-CanvasUsersPageViews {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The beginning of the time range from which you want page views.
        [Parameter(Mandatory=$false)]
        $start_time,

        # The end of the time range from which you want page views.
        [Parameter(Mandatory=$false)]
        $end_time
	)

    $uri = "/api/v1/users/{0}/page_views" -f $UserId 

	$Body = @{}

	if ($start_time) {$Body["start_time"] = $start_time}

	if ($end_time) {$Body["end_time"] = $end_time}

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Store custom data 
.DESCRIPTION
   Store arbitrary user data as JSON. Arbitrary JSON data can be stored for a User. A typical scenario would be an external site/service that registers users in Canvas and wants to capture additional info about them. The part of the URL that follows /custom_data/ defines the scope of the request, and it reflects the structure of the JSON data to be stored or retrieved. The value self may be used for user_id to store data associated with the calling user. In order to access another user's custom data, you must be an account administrator with permission to manage users. A namespace parameter, ns, is used to prevent custom_data collisions between different apps. This parameter is required for all custom_data requests. A request with Content-Type multipart/form-data or Content-Type application/x-www-form-urlencoded can only be used to store strings. Example PUT with multipart/form-data data: Response: Subscopes (or, generated scopes) can also be specified by passing values to data[subscope]. Example PUT specifying subscopes: Response: Following such a request, subsets of the stored data to be retrieved directly from a subscope. Example GET from a generated scope Response: If you want to store more than just strings (i.e. numbers, arrays, hashes, true, false, and/or null), you must make a request with Content-Type application/json as in the following example. Example PUT with JSON data: Response: If the data is an Object (as it is in the above example), then subsets of the data can be accessed by including the object's (possibly nested) keys in the scope of a GET request. Example GET with a generated scope: Response: On success, this endpoint returns an object containing the data that was stored. Responds with status code 200 if the scope already contained data, and it was overwritten by the data specified in the request. Responds with status code 201 if the scope was previously empty, and the data specified in the request was successfully stored there. Responds with status code 400 if the namespace parameter, ns, is missing or invalid, or if the data parameter is missing. Responds with status code 409 if the requested scope caused a conflict and data was not stored. This happens when storing data at the requested scope would cause data at an outer scope to be lost. e.g., if /custom_data was {âfashion_appâ: {âhairâ: âblondeâ}}, but you tried to `PUT /custom_data/fashion_app/hair/style -F data=buzz`, then for the request to succeed,the value of /custom_data/fashion_app/hair would have to become a hash, and its old string value would be lost. In this situation, an error object is returned with the following format:
.EXAMPLE
   PS C:> Put-CanvasUsersCustomData -UserId $SomeUserIdObj -ns $SomensObj -data $SomedataObj
#>
function Put-CanvasUsersCustomData {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The namespace under which to store the data. This should be something other Canvas API apps aren't likely to use, such as a reverse DNS for your organization.
        [Parameter(Mandatory=$true)]
        $ns,

        # The data you want to store for the user, at the specified scope. If the data is composed of (possibly nested) JSON objects, scopes will be generated for the (nested) keys (see examples).
        [Parameter(Mandatory=$true)]
        $data
	)

    $uri = "/api/v1/users/{0}/custom_data(/{1}" -f $UserId 

	$Body = @{}

	$Body["ns"] = $ns

	$Body["data"] = $data

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Load custom data 
.DESCRIPTION
   Load custom user data. Arbitrary JSON data can be stored for a User. This API call retrieves that data for a (optional) given scope. See Store Custom Data for details and examples. On success, this endpoint returns an object containing the data that was requested. Responds with status code 400 if the namespace parameter, ns, is missing or invalid, or if the specified scope does not contain any data.
.EXAMPLE
   PS C:> Get-CanvasUsersCustomData -UserId $SomeUserIdObj -ns $SomensObj
#>
function Get-CanvasUsersCustomData {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The namespace from which to retrieve the data. This should be something other Canvas API apps aren't likely to use, such as a reverse DNS for your organization.
        [Parameter(Mandatory=$true)]
        $ns
	)

    $uri = "/api/v1/users/{0}/custom_data(/{1}" -f $UserId 

	$Body = @{}

	$Body["ns"] = $ns

    return Get-CanvasApiResult $uri -Method GET -RequestParameters $Body
}


<#
.Synopsis
   Delete custom data 
.DESCRIPTION
   Delete custom user data. Arbitrary JSON data can be stored for a User. This API call deletes that data for a given scope. Without a scope, all custom_data is deleted. See Store Custom Data for details and examples of storage and retrieval. As an example, we'll store some data, then delete a subset of it. Example PUT with valid JSON data: Response: Example DELETE: Response: Example GET following the above DELETE: Response: Note that hashes left empty after a DELETE will get removed from the custom_data store. For example, following the previous commands, if we delete /custom_data/veggies/root/onion, then the entire /custom_data/veggies scope will be removed. Example DELETE that empties a parent scope: Response: Example GET following the above DELETE: Response: On success, this endpoint returns an object containing the data that was deleted. Responds with status code 400 if the namespace parameter, ns, is missing or invalid, or if the specified scope does not contain any data.
.EXAMPLE
   PS C:> Delete-CanvasUsersCustomData -UserId $SomeUserIdObj -ns $SomensObj
#>
function Delete-CanvasUsersCustomData {
[CmdletBinding()]

	Param
	(
        # The UserId
        [Parameter(Mandatory=$true)]
        $UserId,

        # The namespace from which to delete the data. This should be something other Canvas API apps aren't likely to use, such as a reverse DNS for your organization.
        [Parameter(Mandatory=$true)]
        $ns
	)

    $uri = "/api/v1/users/{0}/custom_data(/{1}" -f $UserId 

	$Body = @{}

	$Body["ns"] = $ns

    return Get-CanvasApiResult $uri -Method DELETE -RequestParameters $Body
}


<#
.Synopsis
   List course nicknames 
.DESCRIPTION
   Returns all course nicknames you have set.
.EXAMPLE
   PS C:> Get-CanvasUsersSelfCourseNicknames
#>
function Get-CanvasUsersSelfCourseNicknames {
[CmdletBinding()]

    $uri = "/api/v1/users/self/course_nicknames" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Get course nickname 
.DESCRIPTION
   Returns the nickname for a specific course.
.EXAMPLE
   PS C:> Get-CanvasUsersSelfCourseNicknames -CourseId $SomeCourseIdObj
#>
function Get-CanvasUsersSelfCourseNicknames {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/users/self/course_nicknames/{0}" -f $CourseId 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Set course nickname 
.DESCRIPTION
   Set a nickname for the given course. This will replace the course's name in output of API calls you make subsequently, as well as in selected places in the Canvas web user interface.
.EXAMPLE
   PS C:> Put-CanvasUsersSelfCourseNicknames -CourseId $SomeCourseIdObj -nickname $SomenicknameObj
#>
function Put-CanvasUsersSelfCourseNicknames {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The nickname to set. It must be non-empty and shorter than 60 characters.
        [Parameter(Mandatory=$true)]
        $nickname
	)

    $uri = "/api/v1/users/self/course_nicknames/{0}" -f $CourseId 

	$Body = @{}

	$Body["nickname"] = $nickname

    return Get-CanvasApiResult $uri -Method PUT -RequestParameters $Body
}


<#
.Synopsis
   Remove course nickname 
.DESCRIPTION
   Remove the nickname for the given course. Subsequent course API calls will return the actual name for the course.
.EXAMPLE
   PS C:> Delete-CanvasUsersSelfCourseNicknames -CourseId $SomeCourseIdObj
#>
function Delete-CanvasUsersSelfCourseNicknames {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/users/self/course_nicknames/{0}" -f $CourseId 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   Clear course nicknames 
.DESCRIPTION
   Remove all stored course nicknames.
.EXAMPLE
   PS C:> Delete-CanvasUsersSelfCourseNicknames
#>
function Delete-CanvasUsersSelfCourseNicknames {
[CmdletBinding()]

    $uri = "/api/v1/users/self/course_nicknames" 

    return Get-CanvasApiResult $uri -Method DELETE
}


<#
.Synopsis
   List courses with their latest ePub export 
.DESCRIPTION
   Lists all courses a user is actively participating in, and the latest ePub export associated with the user & course.
.EXAMPLE
   PS C:> Get-CanvasEpubExports
#>
function Get-CanvasEpubExports {
[CmdletBinding()]

    $uri = "/api/v1/epub_exports" 

    return Get-CanvasApiResult $uri -Method GET
}


<#
.Synopsis
   Create ePub Export 
.DESCRIPTION
   Begin an ePub export for a course. You can use the Progress API to track the progress of the export. The export's progress is linked to with the progress_url value. When the export completes, use the Show content export endpoint to retrieve a download URL for the exported content.
.EXAMPLE
   PS C:> Post-CanvasCoursesEpubExports -CourseId $SomeCourseIdObj
#>
function Post-CanvasCoursesEpubExports {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId
	)

    $uri = "/api/v1/courses/{0}/epub_exports" -f $CourseId 

    return Get-CanvasApiResult $uri -Method POST
}


<#
.Synopsis
   Show ePub export 
.DESCRIPTION
   Get information about a single ePub export.
.EXAMPLE
   PS C:> Get-CanvasCoursesEpubExports -CourseId $SomeCourseIdObj -Id $SomeIdObj
#>
function Get-CanvasCoursesEpubExports {
[CmdletBinding()]

	Param
	(
        # The CourseId
        [Parameter(Mandatory=$true)]
        $CourseId,

        # The Id
        [Parameter(Mandatory=$true)]
        $Id
	)

    $uri = "/api/v1/courses/{0}/epub_exports/{1}" -f $CourseId, $Id 

    return Get-CanvasApiResult $uri -Method GET
}

