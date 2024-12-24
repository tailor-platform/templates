import { FieldComponentProps, FieldType } from "@fabrix-framework/fabrix";
import chroma from "chroma-js";
import s2c from "string-to-color";
import { useMemo } from "react";
import { Badge } from "@/components/ui/badge";
import { Label } from "@/components/ui/label";
import { CheckCircle } from "lucide-react";

export const OMKSField = (props: FieldComponentProps) => {
  if (props.path.length > 1) {
    return null;
  }

  const { className } = props.attributes;
  const renderValue = () => {
    const { type, value } = props;
    switch (type?.type) {
      case "List":
        return <ListTableField {...props} />;
      default:
        return <SingleValueField type={type} value={value} />;
    }
  };

  return (
    <div className={className}>
      <Label className="mr-2 font-bold">{props.name}:</Label>
      {renderValue()}
    </div>
  );
};

export const SingleValueField = (props: {
  type: FieldType | undefined;
  value: unknown;
}) => {
  const renderAsText = () => <span>{String(value)}</span>;

  const { type, value } = props;
  switch (type?.type) {
    case "Enum":
      return <EnumBadgeField {...props} />;
    case "Scalar":
      switch (type.name) {
        case "Boolean":
          return value ? <CheckCircle /> : "-";
        default:
          return renderAsText();
      }
    case "Object":
      if (value && typeof value === "object" && "name" in value) {
        return <span>{value.name as string}</span>;
      }
    default:
      return renderAsText();
  }
};

export const EnumBadgeField = (props: { value: unknown }) => {
  const stringValue = String(props.value);
  const backgroundColor = s2c(stringValue);
  const textColor = useMemo(() => {
    const bgColor = chroma(backgroundColor);
    const whiteContrast = chroma.contrast(bgColor, "#FFFFFF");
    const blackContrast = chroma.contrast(bgColor, "#000000");
    return whiteContrast > blackContrast ? "#FFFFFF" : "#000000";
  }, [backgroundColor]);

  return (
    <Badge className="" color={textColor}>
      {stringValue}
    </Badge>
  );
};

// TODO: implement correctly
export const ListTableField = (props: FieldComponentProps) => {
  if (!props.subFields || !Array.isArray(props.value)) {
    return;
  }

  return (
    <div>
      {props.value.map((item, index) => (
        <span key={index}>{item}</span>
      ))}
    </div>
  );
};
