part of 'invoice_bloc.dart';

class InvoiceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetInvoicesEvent extends InvoiceEvent{
  GetInvoicesEvent();
}

final class GetMoreInvoicesEvent extends InvoiceEvent{
  GetMoreInvoicesEvent();
}