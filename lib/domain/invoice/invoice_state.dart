part of 'invoice_bloc.dart';

class InvoiceState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class InitialInvoiceState extends InvoiceState{}
final class LoadingInvoiceState extends InvoiceState{}
final class SuccessInvoiceState extends InvoiceState{
  final List<Invoice> invoices;

  SuccessInvoiceState(this.invoices);

  @override
  List<Object?> get props => invoices;
}
final class FailureInvoiceState extends InvoiceState{
  final String message;
  FailureInvoiceState(this.message);
}