<?php

use Illuminate\Database\Seeder;

class PermissionsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('permissions')->truncate();
        $statement = "INSERT INTO `permissions` (`id`, `parent_id`, `name`, `slug`, `description`) VALUES
(1, 0, 'Users', 'users', 'Access Users Module'),
(2, 1, 'View Users', 'users.view', 'View Users'),
(3, 1, 'Create Users', 'users.create', 'Create Users'),
(4, 1, 'Update Users', 'users.update', 'Update Users'),
(5, 1, 'Delete Users', 'users.delete', 'Delete users'),
(7, 1, 'View Roles', 'users.roles.view', 'View Roles'),
(8, 1, 'Create Roles', 'users.roles.create', 'Create Roles'),
(9, 1, 'Update Roles', 'users.roles.update', 'Update Roles'),
(10, 1, 'Delete Roles', 'users.roles.delete', 'Delete Roles'),
(11, 1, 'Assign Roles', 'users.roles.assign', 'Assign User Roles'),
(12, 0, 'Settings', 'settings', 'Access Settings Module'),
(13, 12, 'Update Settings', 'settings.update', 'Update Settings'),
(14, 12, 'View General Settings', 'settings.general.view', 'View General Settings'),
(15, 12, 'View Organisation Settings', 'settings.organisation.view', 'View Organisation Settings'),
(16, 0, 'Accounting', 'accounting', 'Access Accounting Module'),
(17, 16, 'View Chart of Accounts', 'accounting.gl_accounts.view', 'View Chart of Accounts'),
(18, 16, 'Create Chart of Accounts', 'accounting.gl_accounts.create', 'Create Chart of Accounts'),
(19, 16, 'Update Chart of Accounts', 'accounting.gl_accounts.update', 'Update Chart of Accounts'),
(20, 16, 'Delete Chart of Accounts', 'accounting.gl_accounts.delete', 'Delete Chart of Accounts'),
(21, 16, 'View Journals', 'accounting.journals.view', 'View Journals'),
(22, 16, 'Create Manual Journals', 'accounting.journals.create', 'Create Manual Journals'),
(23, 16, 'Delete Manual Journals', 'accounting.journals.delete', 'Delete Manual Journals'),
(24, 16, 'Approve Manual Journals', 'accounting.journals.approve', 'Approve Manual Journals'),
(25, 16, 'View Reconciliations', 'accounting.journals.reconciliation.view', 'View Reconciliations'),
(26, 16, 'Reconcile Journal Entries', 'accounting.journals.reconciliation.create', 'Reconcile Journal Entries'),
(27, 16, 'View Accounting Close Period', 'accounting.period.view', 'View  Accounting Close Period'),
(28, 16, 'Create Accounting Close Period', 'accounting.period.create', 'Create Accounting Close Period'),
(29, 16, 'Delete Accounting Close Period', 'accounting.period.delete', 'Delete Accounting Close Period'),
(30, 0, 'Audit Trail', 'audit_trail', 'Access Audit Trail Module'),
(31, 0, 'Branches', 'offices', 'Access Branches Module'),
(32, 31, 'View Branches', 'offices.view', 'View Branches'),
(33, 31, 'Create Branches', 'offices.create', 'Create Branches'),
(34, 31, 'Update Branches', 'offices.update', 'Update Branches'),
(35, 31, 'Delete Branches', 'offices.delete', 'Delete Branches'),
(36, 0, 'Clients', 'clients', 'Access Clients Module'),
(37, 36, 'View Clients', 'clients.view', 'View Clients'),
(38, 36, 'Create Clients', 'clients.create', 'Create Clients'),
(39, 36, 'Update Clients', 'clients.update', 'Update Clients'),
(40, 36, 'Delete Clients', 'clients.delete', 'Delete Clients'),
(41, 36, 'Approve Clients', 'clients.approve', 'Approve Clients'),
(42, 36, 'Close Client', 'clients.close', 'Close Client'),
(43, 36, 'View  Client Pending approval', 'clients.pending_approval', 'View  Client Pending approval'),
(44, 36, 'View Closed Clients', 'clients.closed', 'View Closed Clients'),
(45, 36, 'Create Client Document', 'clients.documents.create', 'Create Client Document'),
(46, 36, 'Read Client Document', 'clients.documents.view', 'Read Client Document'),
(47, 36, 'Delete Client Document', 'clients.documents.delete', 'Delete Client Document'),
(48, 36, 'Update Client Document', 'clients.documents.update', 'Update Client Document'),
(49, 36, 'Read Next Of Kin', 'clients.next_of_kin.view', 'Read Next Of Kin'),
(50, 36, 'Create Next Of Kin', 'clients.next_of_kin.create', 'Create Next Of Kin'),
(51, 36, 'Update Next Of Kin', 'clients.next_of_kin.update', 'Update Next Of Kin'),
(52, 36, 'Delete Next Of Kin', 'clients.next_of_kin.delete', 'Delete Next Of Kin'),
(53, 36, 'Read Client Identifiers', 'clients.identification.view', 'Read Client Identifiers'),
(54, 36, 'Create Client Identifiers', 'clients.identification.create', 'Create Client Identifiers'),
(55, 36, 'Update Client Identifiers', 'clients.identification.update', 'Update Client Identifiers'),
(56, 36, 'Delete Client identifier', 'clients.identification.delete', 'Delete Client identifier'),
(57, 36, 'Read Client notes', 'clients.notes.view', 'Read Client notes'),
(58, 36, 'Create Client notes', 'clients.notes.create', 'Create Client notes'),
(59, 36, 'Update Client notes', 'clients.notes.update', 'Update Client notes'),
(60, 36, 'Delete Client notes', 'clients.notes.delete', 'Delete Client notes'),
(61, 36, 'Read Client Accounts', 'clients.accounts.view', 'Read Client Accounts'),
(62, 36, 'Transfer Client', 'clients.transfer.client', 'Transfer Client'),
(63, 36, 'Approve Client Transfer', 'clients.transfer.approve', 'Approve Client Transfer'),
(64, 0, 'Groups', 'groups', 'Access Groups Module'),
(65, 64, 'View Groups', 'groups.view', 'View Groups'),
(66, 64, 'Create Group', 'groups.create', 'Create Group'),
(67, 64, 'Approve Group', 'groups.approve', 'Approve Group'),
(68, 64, 'Update Groups', 'groups.update', 'Update Groups'),
(69, 64, 'Add Client to Group', 'groups.client.create', 'Add Client to Group'),
(70, 64, 'Remove Client', 'groups.client.delete', 'Remove Client'),
(71, 64, 'View Group Document', 'groups.documents.view', 'View  Group Document'),
(72, 64, 'Add Group Document', 'groups.documents.create', 'Add Group Document'),
(73, 64, 'Update Group Document', 'groups.documents.update', 'Update Group Document'),
(74, 64, 'Delete Group Document', 'groups.documents.delete', 'Delete Group Document'),
(75, 64, 'View Group Note', 'groups.notes.view', 'View Group Note'),
(76, 64, 'Create Group Note', 'groups.notes.create', 'Create Group Note'),
(77, 64, 'Update Group Note', 'groups.notes.update', 'Update Group Note'),
(78, 64, 'Delete Group Note', 'groups.notes.delete', 'Delete Group Note'),
(79, 64, 'View Assigned Groups', 'groups.view_assigned', 'View Assigned Groups'),
(80, 64, 'View Created', 'groups.view_created', 'View Created'),
(81, 36, 'View Assigned', 'clients.view_assigned', 'View Assigned'),
(82, 36, 'View Created', 'clients.view_created', 'View Created'),
(83, 0, 'Loans', 'loans', 'Access Loans Module'),
(84, 83, 'View Loans', 'loans.view', 'View Loans'),
(85, 83, 'View Pending Loans', 'loans.pending_approval', 'View Pending Loans'),
(86, 64, 'View Groups Pending Approval', 'groups.pending_approval', 'View Groups Pending Approval'),
(87, 83, 'Awaiting Disbursement', 'loans.awaiting_disbursement', 'Loans Awaiting Disbursement'),
(88, 83, 'Loans Declined', 'loans.declined', 'View Loans Declined'),
(89, 83, 'View Loans Written Off', 'loans.written_off', 'View Loans Written Off'),
(90, 83, 'View Loans Closed', 'loans.closed', 'View Loans Closed'),
(91, 83, 'View Loans Rescheduled', 'loans.rescheduled', 'View Loans Rescheduled'),
(92, 83, 'View Loans Evaluated', 'loans.evaluated', 'View Loans Evaluated'),
(93, 83, 'Create Loans', 'loans.create', 'Create Loans'),
(94, 83, 'Update Loans', 'loans.update', 'Update Loans'),
(95, 83, 'Approve Loan', 'loans.approve', 'Approve Loan'),
(96, 83, 'Disburse Loans', 'loans.disburse', 'Disburse Loans'),
(97, 83, 'Undo Approval', 'loans.undo_approval', 'Disburse Loans'),
(98, 83, 'Undo Disbursement', 'loans.undo_disbursement', 'Undo Disbursement'),
(99, 83, 'Write off loan', 'loans.write_off', 'Write off loan'),
(100, 83, 'Undo Write off', 'loans.undo_write_off', 'Undo Write off'),
(101, 83, 'Waive Loan Interest', 'loans.waive_interest', 'Waive Loan Interest'),
(102, 83, 'Apply charge to loan', 'loans.charge.create', 'Apply charge to loan'),
(103, 83, 'Waive Loan Charge', 'loans.charge.waive', 'Waive Loan Charge'),
(104, 83, 'View Assigned Loans', 'loans.view_assigned', 'View Assigned Loans'),
(105, 83, 'Create Loan Reschedule', 'loans.reschedule.create', 'Create Loan Reschedule'),
(106, 83, 'Make Repayment', 'loans.transactions.create', 'Make Repayment'),
(107, 83, 'View Transactions', 'loans.transactions.view', 'View Transactions'),
(108, 83, 'Approve Loan Repayment', 'loans.transactions.approve', 'Approve Loan Repayment'),
(109, 83, 'Adjust Loan Transaction', 'loans.transactions.update', 'Adjust Loan Transaction'),
(110, 83, 'View System Reversed Transactions', 'loans.transactions.system_reversed', 'View System Reversed Transactions'),
(111, 83, 'View Loan Repayment Schedule', 'loans.view_repayment_schedule', 'View Loan Repayment Schedule'),
(112, 83, 'View Loan Documents', 'loans.documents.view', 'View Loan Documents'),
(113, 83, 'Create Loan Documents', 'loans.documents.create', 'Create Loan Documents'),
(114, 83, 'Update Loan Documents', 'loans.documents.update', 'Update Loan Documents'),
(115, 83, 'Delete Loan Documents', 'loans.documents.delete', 'Delete Loan Documents'),
(116, 83, 'View Collateral', 'loans.collateral.view', 'View Collateral'),
(117, 83, 'Create Collateral', 'loans.collateral.create', 'Create Collateral'),
(118, 83, 'Update Collateral', 'loans.collateral.update', 'Update Collateral'),
(119, 83, 'Delete Collateral', 'loans.collateral.delete', 'Delete Collateral'),
(120, 83, 'View Guarantors', 'loans.guarantors.view', 'View Guarantors'),
(121, 83, 'Create Guarantors', 'loans.guarantors.create', 'Create Guarantors'),
(122, 83, 'Update Guarantors', 'loans.guarantors.update', 'Update Guarantors'),
(123, 83, 'Delete Guarantors', 'loans.guarantors.delete', 'Delete Guarantors'),
(124, 83, 'View Loan Notes', 'loans.notes.view', 'View Loan Notes'),
(125, 83, 'Create Loan Notes', 'loans.notes.create', 'Create Loan Notes'),
(126, 83, 'Update Loan Notes', 'loans.notes.update', 'Update Loan Notes'),
(127, 83, 'Delete Loan Notes', 'loans.notes.delete', 'Delete Loan Notes'),
(128, 83, 'View Group Allocation', 'loans.view_group_allocation', 'View Group Allocation'),
(129, 83, 'View Client Details', 'loans.view_client_details', 'View Client Details'),
(130, 83, 'Email Schedule', 'loans.email_schedule', 'Email Schedule'),
(131, 83, 'Pdf Schedule', 'loans.pdf_schedule', 'Pdf Schedule'),
(132, 0, 'Savings', 'savings', 'Access Savings Module'),
(133, 132, 'View Savings', 'savings.view', 'View Savings'),
(134, 132, 'View Savings Pending Approval', 'savings.pending_approval', 'View Savings Pending Approval'),
(135, 132, 'View Approved Savings Accounts', 'savings.approved', 'View Approved Savings Accounts'),
(136, 132, 'View Savings Closed', 'savings.closed', 'View Savings Closed'),
(137, 132, 'Create Savings', 'savings.create', 'Create Savings'),
(138, 132, 'Update Savings', 'savings.update', 'Update Savings'),
(139, 132, 'Delete Savings', 'savings.delete', 'Delete Savings'),
(140, 132, 'Approve Savings', 'savings.approve', 'Approve Savings'),
(141, 132, 'Undo Approval', 'savings.undo_approval', 'Undo Approval'),
(142, 132, 'Close Savings Account', 'savings.close', 'Close Savings Account'),
(143, 132, 'View Transactions', 'savings.transactions.view', 'View Transactions'),
(144, 132, 'Create Transactions', 'savings.transactions.create', 'Create Transactions'),
(145, 132, 'Update Transactions', 'savings.transactions.update', 'Update Transactions'),
(146, 132, 'Delete Transactions', 'savings.transactions.delete', 'Delete Transaction'),
(147, 132, 'View Documents', 'savings.documents.view', 'View Documents'),
(148, 132, 'Create Savings Documents', 'savings.documents.create', 'Create Savings Documents'),
(149, 132, 'Update Savings Documents', 'savings.documents.update', 'Update Savings Documents'),
(150, 132, 'Delete Savings Documents', 'savings.documents.delete', 'Delete Savings Documents'),
(151, 132, 'View Savings Notes', 'savings.notes.view', 'View Savings Notes'),
(152, 132, 'Create Savings Notes', 'savings.notes.create', 'Create Savings Notes'),
(153, 132, 'Update Savings Notes', 'savings.notes.update', 'Update Savings Notes'),
(154, 132, 'Delete Savings Notes', 'savings.notes.delete', 'Delete Savings Notes'),
(155, 132, 'Post Interest', 'savings.post_interest', 'Post Interest'),
(156, 132, 'Email Statement', 'savings.email_statement', 'Email Statement'),
(157, 132, 'Pdf Statement', 'savings.pdf_statement', 'Pdf Statement'),
(158, 132, 'Add Charge To Savings Account', 'savings.charge.create', 'Add Charge To Savings Account'),
(159, 132, 'Waive Saving Account Charge', 'savings.charge.waive', 'Waive Saving Account Charge'),
(160, 132, 'Approve Savings Transaction', 'savings.transactions.approve', 'Approve Savings Transaction'),
(161, 132, 'Make Deposit', 'savings.transactions.deposit', 'Make Deposit'),
(162, 132, 'Make Withdrawal', 'savings.transactions.withdrawal', 'Make Withdrawal'),
(163, 0, 'Products', 'products', 'Access Savings & Loan Products and related modules'),
(164, 163, 'View Charges', 'products.charges.view', 'View Charges'),
(165, 163, 'Create Charge', 'products.charges.create', 'Create Charge'),
(166, 163, 'Update Charge', 'products.charges.update', 'Update Charge'),
(167, 163, 'Delete Charge', 'products.charges.delete', 'Delete Charge'),
(168, 163, 'View Currencies', 'products.currencies.view', 'View Currencies'),
(169, 163, 'Create Currency', 'products.currencies.create', 'Create Currency'),
(170, 163, 'Update Currency', 'products.currencies.update', 'Update Currency'),
(171, 163, 'Delete Currencies', 'products.currencies.delete', 'Delete Currencies'),
(172, 163, 'Funds', 'products.funds.view', 'Funds'),
(173, 163, 'Create Funds', 'products.funds.create', 'Create Funds'),
(174, 163, 'Update Funds', 'products.funds.update', 'Update Funds'),
(175, 163, 'Delete Funds', 'products.funds.delete', 'Delete Funds'),
(176, 163, 'View Payment Types', 'products.payment_types.view', 'View Payment Types'),
(177, 163, 'Create Payment types', 'products.payment_types.create', 'Create Payment types'),
(178, 163, 'Update Payment Types', 'products.payment_types.update', 'Update Payment Types'),
(179, 163, 'Delete Payment Types', 'products.payment_types.delete', 'Delete Payment Types'),
(180, 163, 'View Loan Purpose', 'products.loan_purposes.view', 'View Loan Purpose'),
(181, 163, 'Create Loan Purpose', 'products.loan_purposes.create', 'Create Loan Purpose'),
(182, 163, 'Delete Loan Purpose', 'products.loan_purposes.delete', 'Delete Loan Purpose'),
(183, 163, 'Update Loan Purpose', 'products.loan_purposes.update', 'Update Loan Purpose'),
(184, 163, 'View Collateral Types', 'products.collateral_types.view', 'View Collateral Types'),
(185, 163, 'Create Collateral Types', 'products.collateral_types.create', 'Create Collateral Types'),
(186, 163, 'Update Collateral Types', 'products.collateral_types.update', 'Update Collateral Types'),
(187, 163, 'Delete Collateral Types', 'products.collateral_types.delete', 'Delete Collateral Types'),
(188, 163, 'View Client Relationship', 'products.client_relationships.view', 'View Client Relationship'),
(189, 163, 'Create Client Relationship', 'products.client_relationships.create', 'Create Client Relationship'),
(190, 163, 'Update Client Relationship', 'products.client_relationships.update', 'Update Client Relationship'),
(191, 163, 'Delete Client Relationship', 'products.client_relationships.delete', 'Delete Client Relationship'),
(192, 163, 'View Client Identification Type', 'products.client_identification_types.view', 'View Client Identification Type'),
(193, 163, 'Create Client Identification Type', 'products.client_identification_types.create', 'Create Client Identification Type'),
(194, 163, 'Update Client Identification Type', 'products.client_identification_types.update', 'Update Client Identification Type'),
(195, 163, 'Delete Client Identification Type', 'products.client_identification_types.delete', 'Delete Client Identification Type'),
(196, 163, 'Manage Loan Provisioning Criteria', 'products.loan_provisioning_criteria.update', 'Manage Loan Provisioning Criteria'),
(197, 163, 'View Loan Products', 'products.loan_products.view', 'View Loan Products'),
(198, 163, 'Create Loan Products', 'products.loan_products.create', 'Create Loan Products'),
(199, 163, 'Update Loan Products', 'products.loan_products.update', 'Update Loan Products'),
(200, 163, 'Delete Loan Products', 'products.loan_products.delete', 'Delete Loan Products'),
(201, 163, 'View Savings Products', 'products.savings_products.view', 'View Savings Products'),
(202, 163, 'Create Savings Products', 'products.savings_products.create', 'Create View Savings Products'),
(203, 163, 'Update Savings Products', 'products.savings_products.update', 'Update Savings Products'),
(204, 163, 'Delete Savings Products', 'products.savings_products.delete', 'Delete Savings Products'),
(205, 0, 'Reports', 'reports', 'Access Reports Module'),
(206, 205, 'Downloading/Exporting of Reports', 'reports.downloading_exporting_of_reports', 'Downloading/Exporting of Reports'),
(207, 205, 'Client Reports', 'reports.client_reports', 'Access Client Reports Menu'),
(208, 205, 'Loan Reports', 'reports.loan_reports', 'Access Loan Reports Menu'),
(209, 205, 'Financial Reports', 'reports.financial_reports', 'Financial Reports'),
(210, 205, 'Savings Reports', 'reports.savings_reports', 'Access Savings Reports Menu'),
(211, 205, 'Reports Scheduler', 'reports.reports_scheduler', 'Access Reports Scheduler Menu'),
(212, 205, 'Client Numbers Report', 'reports.client_numbers_report', 'Client Numbers Report'),
(213, 205, 'Collection Sheet', 'reports.collection_sheet', 'Collection Sheet'),
(214, 205, 'Repayments Report', 'reports.repayments_report', 'Repayments Report'),
(215, 205, 'Expected Repayment', 'reports.expected_repayment', 'Expected Repayment'),
(216, 205, 'Arrears Report', 'reports.arrears_report', 'Arrears Report'),
(217, 205, 'Disbursed Loans', 'reports.disbursed_loans', 'Disbursed Loans'),
(218, 205, 'Loan Portfolio', 'reports.loan_portfolio', 'Loan Portfolio'),
(219, 205, 'Balance Sheet', 'reports.balance_sheet', 'Balance Sheet'),
(220, 205, 'Trial Balance', 'reports.trial_balance', 'Trial Balance'),
(221, 205, 'Income Statement', 'reports.income_statement', 'Income Statement'),
(222, 205, 'Provisioning', 'reports.provisioning', 'Provisioning'),
(223, 205, 'Journals Report', 'reports.journals_report', 'Journals Report'),
(224, 205, 'Savings Transactions', 'reports.savings_transactions', 'Savings Transactions'),
(225, 205, 'Savings Accounts Report', 'reports.savings_accounts_report', 'Savings Accounts Report'),
(226, 205, 'View Report Scheduler', 'reports.reports_scheduler.view', 'View Report Scheduler'),
(227, 205, 'Create Report Scheduler', 'reports.reports_scheduler.create', 'Create Report Scheduler'),
(228, 205, 'Update Report Scheduler', 'reports.reports_scheduler.update', 'Update Report Scheduler'),
(229, 205, 'Delete Report Scheduler', 'reports.reports_scheduler.delete', 'Delete Report Scheduler'),
(230, 0, 'Communication', 'communication', 'Access Communication Module'),
(231, 230, 'View Campaigns', 'communication.view', 'View Campaigns'),
(232, 230, 'Create Campaign', 'communication.create', 'Create Campaign'),
(233, 230, 'Update Campaign', 'communication.update', 'Update Campaign'),
(234, 230, 'Delete Campaign', 'communication.delete', 'Delete Campaign'),
(235, 230, 'Approve Campaign', 'communication.approve', 'Approve Campaign'),
(236, 0, 'Dashboard', 'dashboard', 'Dashboard'),
(237, 236, 'Loans Disbursed', 'dashboard.loans_disbursed', 'View Loans Disbursed'),
(238, 236, 'Total Repayments', 'dashboard.total_repayments', 'Total Repayments'),
(239, 236, 'Total Outstanding', 'dashboard.total_outstanding', 'Total Outstanding'),
(240, 236, 'Amount in Arrears', 'dashboard.amount_in_arrears', 'Amount in Arrears'),
(241, 236, 'Fees Earned', 'dashboard.fees_earned', 'Fees Earned'),
(242, 236, 'Fees Paid', 'dashboard.fees_paid', 'Fees Paid'),
(243, 236, 'Penalties Paid', 'dashboard.penalties_paid', 'Penalties Paid'),
(244, 236, 'Penalties Earned', 'dashboard.penalties_earned', 'Penalties Earned'),
(245, 236, 'Loans Status Overview', 'dashboard.loans_status_overview', 'Loans Status Overview'),
(246, 236, 'Clients Overview', 'dashboard.clients_overview', 'Clients Overview'),
(247, 236, 'Savings Balances Overview', 'dashboard.savings_balances_overview', 'Savings Balances Overview'),
(248, 236, 'My Loan Repayments', 'dashboard.my_loan_repayments', 'My Loan Repayments'),
(249, 236, 'My Disbursed loans', 'dashboard.my_disbursed_loans', 'My Disbursed loans'),
(250, 236, 'My Number of outstanding loans', 'dashboard.my_number_of_outstanding_loans', 'My Number of outstanding loans'),
(251, 236, 'My Outstanding Loan balance', 'dashboard.my_outstanding_loan_balance', 'My Outstanding Loan balance'),
(252, 236, 'My Clients', 'dashboard.my_clients', 'My Clients'),
(253, 236, 'My written off Amount', 'dashboard.my_written_off_amount', 'My written off Amount'),
(254, 236, 'Collection Statistics', 'dashboard.collection_statistics', 'Collection Statistics'),
(255, 0, 'Custom Fields', 'custom_fields', 'Access Custom Fields'),
(256, 255, 'View Custom Fields', 'custom_fields.view', 'View Custom Fields'),
(257, 255, 'Create Custom Fields', 'custom_fields.create', 'Create Custom Fields'),
(258, 255, 'Update Custom Fields', 'custom_fields.update', 'Update Custom Fields'),
(259, 255, 'Delete Custom Fields', 'custom_fields.delete', 'Delete Custom Fields'),
(260, 0, 'Assets', 'assets', 'Access assets module'),
(261, 260, 'View Assets', 'assets.view', 'View Assets'),
(262, 260, 'Create Assets', 'assets.create', 'Create Assets'),
(263, 260, 'Update Assets', 'assets.update', 'Update Assets'),
(264, 260, 'Delete Assets', 'assets.delete', 'Delete Assets'),
(265, 260, 'View Asset Types', 'assets.types.view', 'View Asset Types'),
(266, 260, 'Create  Asset Types', 'assets.types.create', 'Create  Asset Types'),
(267, 260, 'Update Asset Types', 'assets.types.update', 'Update Asset Types'),
(268, 260, 'Delete Asset Types', 'assets.types.delete', 'Delete Asset Types'),
(269, 0, 'Expenses', 'expenses', 'View Expenses Module'),
(270, 269, 'View Expenses Module', 'expenses.view', 'View Expenses Module'),
(271, 269, 'Create Expenses', 'expenses.create', 'Create Expenses Module'),
(272, 269, 'Update Expenses', 'expenses.update', 'Update Expenses'),
(273, 269, 'Delete Expenses', 'expenses.delete', 'Delete Expenses'),
(274, 269, 'View Expense Types', 'expenses.types.view', 'View Expense Types'),
(275, 269, 'Create Expenses Types', 'expenses.types.create', 'Create Expenses Types'),
(276, 269, 'Update Expenses Types', 'expenses.types.update', 'Update Expenses Types'),
(277, 269, 'Delete Expense Types', 'expenses.types.delete', 'Delete Expense Types'),
(278, 0, 'Other Income', 'other_income', 'View Other Income'),
(279, 278, 'View Other Income', 'other_income.view', 'View Other Income'),
(280, 278, 'Create Other Income', 'other_income.create', 'Create Other Income'),
(281, 278, 'Update Other Income', 'other_income.update', 'Update Other Income'),
(282, 278, 'Delete Other Income', 'other_income.delete', 'Delete Other Income'),
(283, 278, 'View Other Income types', 'other_income.types.view', 'View Other Income types'),
(284, 278, 'Create Other Income types', 'other_income.types.create', 'Create Other Income types'),
(285, 278, 'Update Other Income types', 'other_income.types.update', 'Update Other Income types'),
(286, 278, 'Delete Other Income types', 'other_income.types.delete', 'Delete Other Income types'),
(287, 269, 'View Budget', 'expenses.budget.view', 'View Budget'),
(288, 269, 'Create Budget', 'expenses.budget.create', 'Create Budget'),
(289, 269, 'Update Budget', 'expenses.budget.update', 'Update Budget'),
(290, 269, 'Delete Budget', 'expenses.budget.delete', 'Delete Budget'),
(291, 0, 'Payroll', 'payroll', 'Access Payroll templates'),
(292, 291, 'View Payroll', 'payroll.view', 'View Payroll'),
(293, 291, 'Create Payroll', 'payroll.create', NULL),
(294, 291, 'Update Payroll', 'payroll.update', NULL),
(295, 291, 'Delete Payroll', 'payroll.delete', NULL),
(297, 296, 'View Grants', 'grants.view', 'View Grants'),
(298, 296, 'Create Grant', 'grants.create', NULL),
(299, 296, 'Update Grant', 'grants.update', NULL),
(300, 296, 'Delete Grant', 'grants.delete', NULL),
(301, 296, 'Approve Grants', 'grants.approve', NULL),
(302, 296, 'Undo approval', 'grants.undo_approval', NULL),
(303, 296, 'Disburse Grants', 'grants.disburse', NULL),
(304, 296, 'Undo disbursement', 'grants.undo_disbursement', NULL),
(305, 296, 'View Grants Pending Approval', 'grants.pending_approval', NULL),
(306, 296, 'View Grants Awaiting Disbursement', 'grants.awaiting_disbursement', NULL),
(307, 296, 'View Grants Declined', 'grants.declined', NULL),
(308, 296, 'View Documents', 'grants.documents.view', NULL),
(309, 296, 'Create Documents', 'grants.documents.create', NULL),
(310, 296, 'Update Documents', 'grants.documents.update', NULL),
(311, 296, 'Delete Documents', 'grants.documents.delete', NULL),
(312, 296, 'View Notes', 'grants.notes.view', NULL),
(313, 296, 'Create Notes', 'grants.notes.create', NULL),
(314, 296, 'Update Notes', 'grants.notes.update', NULL),
(315, 296, 'Delete Notes', 'grants.notes.delete', NULL),
(316, 236, 'Grants Status Overview', 'dashboard.grants_status_overview', NULL),
(317, 236, 'Grants Disbursement Overview', 'dashboard.grants_disbursement_overview', NULL),
(318, 205, 'Grant Reports', 'reports.grant_reports', NULL),
(319, 205, 'Age Analysis', 'reports.age_analysis_reports', NULL),
(320, 205, 'Client Listing', 'reports.client_list_reports', NULL),
(321, 205, 'Daily Transaction', 'reports.daily_transactions_reports', NULL),
(322, 205, 'Loan Book', 'reports.loan_book', NULL);";
        DB::unprepared($statement);
    }
}
