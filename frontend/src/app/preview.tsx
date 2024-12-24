"use client";
import { FabrixComponent, gql } from "@fabrix-framework/fabrix";
import { ErrorBoundary, FallbackProps } from "react-error-boundary";

const ErrorComponent = (props: FallbackProps) => {
  return (
    <div>
      <h1>Something went wrong</h1>
      <pre>{props.error.message}</pre>
    </div>
  );
};

export const Preview = () => {
  return (
    <ErrorBoundary FallbackComponent={ErrorComponent}>
      <FabrixComponent
        query={gql`
          query {
            manufacturingOrders {
              edges {
                node {
                  id
                  name
                  bom {
                    id
                    name
                  }
                  item {
                    id
                    name
                  }
                  startDateTime
                  endDateTime
                  moBatchId
                }
              }
            }
          }
        `}
      />
    </ErrorBoundary>
  );
};
