import { Contact } from "@/app/lib/IMS/types.generated";

type Props = {
  contact: Contact;
};

export const OverviewTab = ({ contact }: Props) => {
  return (
    <div className="flex flex-col gap-4 rounded-xl">
      <div className="flex flex-col gap-4 rounded-xl border p-4">
        <header className="text-sm text-muted-foreground">Overview</header>

        <div className="flex flex-col gap-4">
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Email</span>
            <span className="text-sm text-primary">{contact.email}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Phone</span>
            <span className="text-sm text-primary">{contact.phone}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Company</span>
            <span className="text-sm text-primary">{contact.company}</span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Credit Limit</span>
            <span className="text-sm text-primary">
              ${contact.creditLimit?.toFixed(2)}
            </span>
          </div>
          <div className="flex items-center justify-between gap-2">
            <span className="text-sm text-muted-foreground">Address</span>
            <span className="text-sm text-primary">
              {contact.address1}
              {contact.address2 && `, ${contact.address2}`}
              {`, ${contact.city}, ${contact.province} ${contact.zip}`}
            </span>
          </div>
        </div>
      </div>
    </div>
  );
};
