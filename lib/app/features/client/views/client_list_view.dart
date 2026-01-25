import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:carenest/app/features/client/providers/client_provider.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientListView extends ConsumerStatefulWidget {
  const ClientListView({super.key});

  @override
  ConsumerState<ClientListView> createState() => _ClientListViewState();
}

class _ClientListViewState extends ConsumerState<ClientListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadClients();
    });
  }

  Future<void> _loadClients() async {
    final organizationId = ref.read(organizationIdProvider);
    if (organizationId != null && organizationId.isNotEmpty) {
      await ref
          .read(clientProvider.notifier)
          .fetchClientsByOrganization(organizationId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientState = ref.watch(clientProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.backgroundLight,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.clients,
          style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textDark,
              ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: BauhausDesign.space4),
            child: BauhausActionButton(
              text: l10n.addButton,
              icon: Icons.add,
              isSmall: true,
              onPressed: () async {
                await Navigator.pushNamed(context, Routes.addClientDetails);
                _loadClients();
              },
            ),
          ),
        ],
      ),
      body: _buildBody(clientState),
    );
  }

  Widget _buildBody(ClientState state) {
    final l10n = AppLocalizations.of(context)!;

    if (state.isLoading) {
      return BauhausLoadingState(
        message: l10n.loadingClients,
      );
    }

    if (state.error != null) {
      return Center(
        child: BauhausErrorState(
          title: l10n.oopsTitle,
          message: state.error ?? l10n.somethingWentWrong,
          onRetry: _loadClients,
        ),
      );
    }

    if (state.clients.isEmpty) {
      return Center(
        child: BauhausEmptyState(
          title: l10n.noClientsFoundTitle,
          subtitle: l10n.noClientsFoundSubtitle,
          icon: Icons.people_outline,
          actionLabel: l10n.addClientButton,
          onAction: () async {
            await Navigator.pushNamed(context, Routes.addClientDetails);
            _loadClients();
          },
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        children: [
          ...state.clients.map((client) => _buildClientCard(context, client)),
        ],
      ),
    );
  }

  Widget _buildClientCard(BuildContext context, Patient client) {
    return Padding(
      padding: EdgeInsets.only(bottom: BauhausDesign.space4),
      child: BauhausCard(
        padding: EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                  ),
                  child: Icon(
                    Icons.person,
                    color: BauhausDesign.secondary,
                    size: 24,
                  ),
                ),
                SizedBox(width: BauhausDesign.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        client.displayName,
                        style: BauhausDesign.getTextTheme(context)
                            .titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: BauhausDesign.textDark,
                            ),
                      ),
                      SizedBox(height: BauhausDesign.space1),
                      Text(
                        client.clientEmail,
                        style: BauhausDesign.getTextTheme(context)
                            .bodyMedium
                            ?.copyWith(
                              color: BauhausDesign.textMuted,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: BauhausDesign.space4),
              child: Divider(
                color: BauhausDesign.neutral.withOpacity(0.2),
                height: 1,
              ),
            ),
            if (client.clientPhone != null && client.clientPhone!.isNotEmpty)
              _buildInfoRow(context, Icons.phone_outlined, client.clientPhone!),
            if (client.clientPhone != null && client.clientPhone!.isNotEmpty)
              SizedBox(height: BauhausDesign.space2),
            if (client.clientAddress != null &&
                client.clientAddress!.isNotEmpty)
              _buildInfoRow(context, Icons.location_on_outlined,
                  '${client.clientAddress}, ${client.clientCity ?? ''}'),
            
            if (!client.isActivated) ...[
              SizedBox(height: BauhausDesign.space4),
              Divider(color: BauhausDesign.neutral.withOpacity(0.2), height: 1),
              SizedBox(height: BauhausDesign.space4),
              SizedBox(
                width: double.infinity,
                child: BauhausActionButton(
                  text: 'Activate Client Account',
                  icon: Icons.lock_open,
                  variant: BauhausActionVariant.secondary,
                  isSmall: true,
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Activate Client Account?'),
                        content: Text('This will generate a temporary password and email it to ${client.clientEmail}.'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
                          TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Activate')),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      await ref.read(clientProvider.notifier).activateClient(client.clientEmail);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Activation email sent to ${client.clientEmail}')),
                      );
                    }
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: BauhausDesign.textMuted,
        ),
        SizedBox(width: BauhausDesign.space2),
        Expanded(
          child: Text(
            text,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
